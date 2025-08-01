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

    Write-Host "Customer Names: $customers"


    # Run a Terraform command for each customer
    $basePath = (Get-Location).Path

    $jobs = @()

    foreach ($customer in $customers) {
        $jobs += Start-Job -Name $customer -ArgumentList $customer, $command, $basePath -ScriptBlock {
        param($customerName, $command, $basePath)
            Write-Host "Working Directory: $basePath" -ForegroundColor Yellow
            $workingDir = Resolve-Path -Path "$customerName"
            Set-Location -Path $workingDir

            Write-Host "Running terraform $TerraformCommand for: [$($customerName)]" -ForegroundColor Green
            try {
                Invoke-Expression $command
                
                # Check the to see if new apps are being created, to trigger a script to consent to scopes
                if ($command.ToLower().Contains("plan")) {
                    terraform plan -out=tfplan.out
                    terraform show -json tfplan.out > tfplan.json

                    $tfplan = Get-Content tfplan.json | ConvertFrom-Json

                    $appCreated = $false

                    foreach ($change in $tfplan.resource_changes) {
                        if ($change.type -eq "azuread_application" -and $change.change.actions -contains "create") {
                            $appCreated = $true
                            break
                        }
                    }

                    echo "NEW_APP_CREATED=$appCreated" >> $Env:GITHUB_ENV
                }
            } catch {
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

    if ($appCreated) {
        Write-host "This plan will create a new application. On the main branch run, a script will auto grant the admin consent for the request scopes" -ForegroundColor Blue
    }

} catch {
    throw $_
}
