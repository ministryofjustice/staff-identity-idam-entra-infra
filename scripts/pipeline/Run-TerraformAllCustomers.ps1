[CmdletBinding()]
param (
    [ValidateNotNullOrEmpty()]
    [string]$Env,

    [ValidateNotNullOrEmpty()]
    [string]$TerraformCommand,

    [switch]$TerraformPlanAndApply
)
$PSNativeCommandUseErrorActionPreference = $true

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

    Write-Host "Customer Names: $customers"


    # Run a Terraform command for each customer
    $basePath = (Get-Location).Path

    $jobs = @()
    $newAADApp = "false"

    foreach ($customer in $customers) {
        $jobs += Start-Job -Name $customer -ArgumentList $customer, $command, $basePath -ScriptBlock {
        param($customerName, $command, $basePath)
            Write-Host "Working Directory: $basePath" -ForegroundColor Yellow
            $workingDir = Resolve-Path -Path "$customerName"
            Set-Location -Path $workingDir

            Write-Host "Running terraform $TerraformCommand for: [$($customerName)]" -ForegroundColor Green
            try {
                Invoke-Expression $command

                Write-Host "Outputting TFplan to JSON" -ForegroundColor Yellow
                terraform show -json $OutFilePath | Out-File -Encoding utf8 -Path "./tfplan.json"

                $json = Get-Content -Path './tfplan.json' | ConvertFrom-Json
                Write-Host "Jason content is: [$json]"

                # Check for azuread_application creation
                Write-Host "Checking to see if a new app is being created"
                $createdApps = $json.resource_changes | Where-Object {
                    $_.type -eq "azuread_application" -and $_.change.actions -contains "create"
                }

                if ($createdApps) {
                    $newAADApp = "true"
                    Write-Host "New app is being created"
                }

            } catch {
                Write-Host "There was an error running the customers plan"
                throw $_.Exception.Message
            }

            # Set location back to the base envs folder
            Set-Location $basePath
        }
        
    }
    # Wait for all jobs to complete
    $jobs | Wait-Job

    foreach ($job in $jobs) {
        Write-Host "Output for Job: $($job.Name)" -ForegroundColor Cyan
        Receive-Job $job
    }

    # Clean up jobs
    $jobs | Remove-Job

    if ($newAADApp) {
        Write-host "This plan will create a new application. On the main branch run, a script will auto grant the admin consent for the request scopes" -ForegroundColor Blue
        Write-Host "Createing env var"
        $env:NEW_AAD_APP = "true"
    } else {
        Write-Host "No new Azure AD apps created."
        $env:NEW_AAD_APP = "false"
    }
} catch {
    throw $_
}
