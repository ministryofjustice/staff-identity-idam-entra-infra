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

# Set Terraform command based on CICD input & get git diff
if ($TerraformPlanAndApply) {
    $command = "terraform apply -lock-timeout=300s -input=false -auto-approve -parallelism=30"
    $diff = git diff --name-only HEAD^ HEAD
    Write-Host "`e[33m Diff output is [$diff] `e[0m"
} else {
    $command = "terraform $TerraformCommand"
    $diff = git diff --name-only HEAD^ HEAD
    Write-Host "`e[33m Diff output is [$diff] `e[0m"
}

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
    "$($_.Name)|$($_.Env)" } | ForEach-Object {
    $_.Group[0]
}

Write-Host "`e[32m Running terraform for Customers $($uniqueCustomers.Name) `e[0m"

# Setup array for jobs output
$jobs = @()

foreach ($customer in $uniqueCustomers) {

    # Due to using GH environments. We need this to skip changed files in one env, triggering a differnet env
    if ($ENV -ne $customer.Env.ToUpper()) {
        Write-Host "`e[31m ⏭️ Skipping $($customer.Name) — environment mismatch ($($customer.Env) vs $ENV) `e[0m"
        continue
    }

    Write-Host "`e[34m✅ Processing $($customer.Name) in environment $($customer.Env)`e[0m" 
    
    $baseDir = "./terraform/envs/$($customer.env)/$($customer.Name)/"

    Push-Location $baseDir

    
    try {
        Write-Host "`e[33m Running Terraform command [$command] `e[0m"
        Invoke-Expression $command
    } catch {
        Write-Host "`e[31m ERROR: $($_.Exception.Message) `e[0m"
        throw
    }

    Pop-Location
}
