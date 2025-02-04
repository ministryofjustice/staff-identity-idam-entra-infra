[CmdletBinding()]
param (
    [ValidateNotNullOrEmpty()]
    [string]$Env,

    [ValidateNotNullOrEmpty()]
    [string]$TerraformCommand,

    [switch]$TerraformPlanAndApply
)
try {
    # Global Vars
    $env = $Env.ToLower()
    $baseDir = "./terraform/envs/$env"

    if ($TerraformPlanAndApply) {
        $command = "terraform apply -lock-timeout=300s -input=false -auto-approve -parallelism=30"
    } else {
        $command = "terraform $TerraformCommand"
    }

    # Get all customers dirs per env
    Set-Location $baseDir
    Write-Host $(Get-Location)
    $customers = Get-ChildItem -Directory | Select-Object -ExpandProperty Name
    Write-Host $customers


    # Run a Terraform command for each customer
    foreach ($customer in $customers) {
        $workingDir = Resolve-Path -Path "$customer"
        Set-Location -Path $workingDir
        Write-Host "Running terraform $TerraformCommand for: [$customer]"
        Invoke-Expression $command
        Set-Location $baseDir
    }
} catch {
    throw $_
}
