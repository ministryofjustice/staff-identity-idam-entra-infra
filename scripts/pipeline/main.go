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

type result struct {
    customer string
    output   string
    err      error
}

func main() {
    env := strings.ToLower(os.Getenv("Env"))
    baseDir := fmt.Sprintf("./terraform/envs/%s", env)

    terraformCommand := os.Getenv("TerraformCommand")
    terraformPlanAndApply := os.Getenv("TerraformPlanAndApply") == "true"

    var command string
    if terraformPlanAndApply {
        command = "terraform apply -lock-timeout=300s -input=false -auto-approve -parallelism=30"
    } else {
        command = fmt.Sprintf("terraform %s", terraformCommand)
    }

    dirs, err := os.ReadDir(baseDir)
    if err != nil {
        log.Fatalf("Failed to read baseDir: %v", err)
    }

    var wg sync.WaitGroup
    results := make(chan result, len(dirs))

    for _, dir := range dirs {
        if dir.IsDir() {
            customer := dir.Name()
            workingDir := filepath.Join(baseDir, customer)

            wg.Add(1)
            go func(customer, workingDir string) {
                defer wg.Done()
                fmt.Printf("🔧 Starting terraform %s for: [%s]\n", terraformCommand, customer)

                cmd := exec.Command("sh", "-c", fmt.Sprintf("cd %s && %s", workingDir, command))
                var outBuf, errBuf bytes.Buffer
                cmd.Stdout = &outBuf
                cmd.Stderr = &errBuf

                err := cmd.Run()
                fullOutput := outBuf.String() + errBuf.String()

                results <- result{customer: customer, output: fullOutput, err: err}
            }(customer, workingDir)
        }
    }

    wg.Wait()
    close(results)

    // Collect and sort results by customer name
    var ordered []result
    for r := range results {
        ordered = append(ordered, r)
    }
    sort.Slice(ordered, func(i, j int) bool {
        return ordered[i].customer < ordered[j].customer
    })

    // Print outputs in order
    for _, r := range ordered {
        fmt.Printf("\n📦 Output for [%s]:\n", r.customer)
        lines := strings.Split(r.output, "\n")
        for _, line := range lines {
            if line != "" {
                fmt.Printf("[%s] %s\n", r.customer, line)
            }
        }
        if r.err != nil {
            fmt.Printf("❌ Error for [%s]: %v\n", r.customer, r.err)
        }
    }
}
