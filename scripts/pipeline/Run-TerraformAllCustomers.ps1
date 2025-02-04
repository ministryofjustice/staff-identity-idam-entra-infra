[CmdletBinding()]
param (
    [ValidateNotNullOrEmpty()]
    [string]$Env,

    [ValidateNotNullOrEmpty()]
    [string]$TerraformCommand
)

# Global Vars
$env = $Env.ToLower()
$baseDir = "./terraform/envs/$env"

# Get all customers dirs per env
Set-Location $baseDir
Write-Host $(Get-Location)
$customers = Get-ChildItem -Directory | Select-Object -ExpandProperty Name
Write-Host $customers

# Set-Location $PSScriptRoot

# # Run a Terraform command for each customer
# foreach ($customer in $customers) {
#     $workingDir = Resolve-Path -Path "$baseDir/$customer"
#     Set-Location -Path $workingDir
#     Write-Host "Running terraform $TerraformCommand for: [$customer]"
#     terraform $TerraformCommand
#     Set-Location $PSScriptRoot
# }
