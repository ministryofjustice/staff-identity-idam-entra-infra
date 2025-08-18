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

if ($TerraformPlanAndApply) {
    $command = "terraform apply -lock-timeout=300s -input=false -auto-approve -parallelism=30"
} else {
    $command = "terraform $TerraformCommand"
}

$diff = git diff --name-only origin/main
Write-Host "`e[33m Diff output is [$diff] `e[0m"

$changedFiles = $diff | ForEach-Object {
    $path = $_.Split("/")

    if ($path -contains "terraform") {
        [PSCustomObject]@{
            Env = $path[2]
            Name = $path[3]
        }
    }
}

$uniqueCustomers = $changedFiles | Group-Object -Property Customer | ForEach-Object {
    $_.Group[0]
}

Write-Host "`e[33m Change will run for $($uniqueCustomers.Name) `e[0m"

Write-Host "`e[32m Runnning terraform for Customers `e[0m"
foreach ($customer in $uniqueCustomers) {
    if ($ENV -ne $customer.Env.ToUpper()) {
        Write-Host "⏭️ Skipping $($customer.Customer) — environment mismatch ($($customer.Env) vs $ENV)" -ForegroundColor DarkGray
        continue
    }

    Write-Host "`e[34m✅ Processing $($customer.Name) in environment $($customer.Env)`e[0m" 

    $baseDir = "./terraform/envs/$($customer.env)/$($customer.Name)/"
    Push-Location $baseDir

    try {
        Write-Host "`e[33m Running Terraform command [$command] `[0m"
        Invoke-Expression $command
    } catch {
        throw $_.Exception.Message
    }


    Pop-Location
}
