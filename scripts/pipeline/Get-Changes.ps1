[CmdletBinding()]
param (
    [ValidateNotNullOrEmpty()]
    [string]$Env,

    [ValidateNotNullOrEmpty()]
    [string]$TerraformCommand,

    [switch]$TerraformPlanAndApply
)

# Global Vars
$env = $Env.ToLower()
$baseDir = "./terraform/envs/$env/"

# Set Terraform command based on CICD input
if ($TerraformPlanAndApply) {
    $command = "terraform apply -lock-timeout=300s -input=false -auto-approve -parallelism=30"
} else {
    $command = "terraform $TerraformCommand"
}

# Get git diff of main and feature branch
$diff = git diff --name-only origin/main
Write-Host "`e[33m Diff output is [$diff] `e[0m"

# Extract the env and customer name from each changed terraform file, based on the filenames of each file in the git diff
$changedFiles = $diff | ForEach-Object {
    $path = $_.Split("/")

    if ($path -contains "terraform") {
        [PSCustomObject]@{
            Env = $path[2]
            Name = $path[3]
        }
    }
}

# Filter changed files for unique customer/env combos to remove duplication, which will happen if you update multiple files for a customer
$uniqueCustomers = $changedFiles | Group-Object {
    "$($_.Customer)|$($_.Env)" } | ForEach-Object {
    $_.Group[0]
}

Write-Host "`e[32m Runnning terraform for Customers $($uniqueCustomers.Name) `e[0m"

# Setup array for jobs output
$jobs = @()

foreach ($customer in $uniqueCustomers) {

    # Due to using GH environments. We need this to skip changed files in one env, triggering a differnet env
    if ($ENV -ne $customer.Env.ToUpper()) {
        Write-Host "⏭️ Skipping $($customer.Name) — environment mismatch ($($customer.Env) vs $ENV)" -ForegroundColor DarkGray
        continue
    }

    Write-Host "`e[34m✅ Processing $($customer.Name) in environment $($customer.Env)`e[0m" 
    
    $baseDir = "./terraform/envs/$($customer.env)/$($customer.Name)/"

    Push-Location $baseDir

    # Setup concurrency for multiple changes to one env
    $jobs += Start-Job -Name $customer.Name -ArgumentList $customer.Name, $command -ScriptBlock {
    param($customerName, $command)
        try {
        Write-Host "`e[33m Running Terraform command [$command] `[0m"
        Invoke-Expression $command
        } catch {
            throw $_.Exception.Message
        }
    }

    # Set location back to the base envs folder
    Pop-Location
}

# Wait for all jobs to complete
$jobs | Wait-Job

# Output job output to console
foreach ($job in $jobs) {
    Write-Host "`e[34m Output for Job: $($job.Name) `e[0m"
    Receive-Job $job
}

# Clean up jobs
$jobs | Remove-Job
