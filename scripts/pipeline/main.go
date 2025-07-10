package main

import (
    "bytes"
    "fmt"
    "log"
    "os"
    "os/exec"
    "path/filepath"
    "sort"
    "strings"
    "sync"
)

// result struct holds the outcome of running Terraform for each customer
type result struct {
    customer string // customer name / directory
    output   string // combined stdout + stderr from Terraform
    err      error  // any execution error
}

func main() {
    // Get environment name (e.g. "dev", "test") from env variable
    env := strings.ToLower(os.Getenv("Env"))

    // Construct the base directory path using the environment
    baseDir := fmt.Sprintf("./terraform/envs/%s", env)

    // Read other env vars to configure Terraform execution
    terraformCommand := os.Getenv("TerraformCommand")
    terraformPlanAndApply := os.Getenv("TerraformPlanAndApply") == "true"

    // Build the Terraform command string
    var command string
    if terraformPlanAndApply {
        // If apply mode is enabled, use full apply flags
        command = "terraform apply -lock-timeout=300s -input=false -auto-approve -parallelism=30"
    } else {
        // Otherwise, use the basic Terraform command (e.g. "plan")
        command = fmt.Sprintf("terraform %s", terraformCommand)
    }

    // Read all subdirectories in the baseDir (representing customers)
    dirs, err := os.ReadDir(baseDir)
    if err != nil {
        log.Fatalf("Failed to read baseDir: %v", err)
    }

    // Set up a WaitGroup to manage concurrency
    var wg sync.WaitGroup

    // Buffered channel to store results (one per customer)
    results := make(chan result, len(dirs))

    // Loop through each customer directory
    for _, dir := range dirs {
        if dir.IsDir() {
            customer := dir.Name()
            workingDir := filepath.Join(baseDir, customer)

            // Increment WaitGroup counter before launching goroutine
            wg.Add(1)

            // Launch a goroutine to run Terraform per customer
            go func(customer, workingDir string) {
                defer wg.Done() // Decrement counter when goroutine completes

                fmt.Printf("🔧 Starting terraform %s for: [%s]\n", terraformCommand, customer)

                // Prepare shell command to cd into the directory and run Terraform
                cmd := exec.Command("sh", "-c", fmt.Sprintf("cd %s && %s", workingDir, command))

                // Capture stdout and stderr
                var outBuf, errBuf bytes.Buffer
                cmd.Stdout = &outBuf
                cmd.Stderr = &errBuf

                // Run the command
                err := cmd.Run()

                // Combine output streams
                fullOutput := outBuf.String() + errBuf.String()

                // Send result to channel
                results <- result{customer: customer, output: fullOutput, err: err}
            }(customer, workingDir)
        }
    }

    // Wait for all goroutines to finish
    wg.Wait()

    // Close results channel now that all writes are done
    close(results)

    // Collect results from channel into a slice
    var ordered []result
    for r := range results {
        ordered = append(ordered, r)
    }

    // Sort results alphabetically by customer name
    sort.Slice(ordered, func(i, j int) bool {
        return ordered[i].customer < ordered[j].customer
    })

    // Display formatted output per customer
    for _, r := range ordered {
        fmt.Printf("\n📦 Output for [%s]:\n", r.customer)

        // Split output into lines and prefix each with customer name
        lines := strings.Split(r.output, "\n")
        for _, line := range lines {
            if line != "" {
                fmt.Printf("[%s] %s\n", r.customer, line)
            }
        }

        // Print error if present
        if r.err != nil {
            fmt.Printf("❌ Error for [%s]: %v\n", r.customer, r.err)
        }
    }
}
