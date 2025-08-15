[CmdletBinding()]
param (
    [ValidateNotNullOrEmpty()]
    [string]$Env = "DEVL",

    [ValidateNotNullOrEmpty()]
    [string]$TerraformCommand = "plan",

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

# Get all customers dirs per env
Set-Location $baseDir
Write-Host $(Get-Location)
$customers = Get-ChildItem -Directory | Select-Object -ExpandProperty Name

Write-Host "Customer Names: $customers"
foreach ($customer in $customers) {
    Write-Host "Working Directory: $customerPath" -ForegroundColor Yellow
    $workingDir = Resolve-Path -Path "$customer"
    Set-Location -Path $workingDir


    $currentPath = Get-Location

    # Define branches
    $mainBranch = "origin/main"
    $currentBranch = git rev-parse --abbrev-ref HEAD

    # Get list of changed files between current branch and main
    $changedFiles = git diff --name-only "$mainBranch...$currentBranch" -- $currentPath

    if ($changedFiles) {
        Write-Host "There are changed files for $customer" -ForegroundColor Green
        Write-Host "Running terraform $TerraformCommand for: [$customer]" -ForegroundColor Green

        try {
            Invoke-Expression $command
        } catch {
            throw $_.Exception.Message
        }
    } else {
        Write-Host "No changes for $customer" -ForegroundColor DarkGray
    }

    Set-Location -Path $baseDir
}
