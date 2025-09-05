[CmdletBinding()]
param (
    [Parameter(Mandatory)]
    [string]$EnvName
)

#region Module Imports
if (-not (Get-Module -ListAvailable -Name "Az" )) {
    # Active Directory Module is not installed
    Install-Module -Name "Az" -Force -Scope CurrentUser
    Write-Host "Az Module has been installed." -ForegroundColor Green
} else {
    Write-Host "Az Module is already installed." -ForegroundColor Yellow
}

try {
    Write-Host "Importing Az module..." -ForegroundColor Yellow
    Import-Module -Name "Az.Accounts", "Az.KeyVault"
    Write-Host "Az module has been imported" -ForegroundColor Green
}
catch {
    throw $_.Exception.Message
}
#endregion

# Global Vars
$EnvName = $EnvName.ToLower()
$envVars = @("TerraformAppClientId", "TerraformClientSecret", "TerraformSubscriptionId", "TerraformTenantId")

# Connect to Azure
try {
    Write-Host "Connecting to Azure" -ForegroundColor Blue
    Connect-AzAccount
} catch {
    throw $_.Exception.Message
}

function Set-EnvironmentVariables {
    param (
        [array]$EnvVars,
        [string]$EnvName
    )

    foreach ($var in $EnvVars) {
        try {
            Write-Host "Attempting to obtain EnvVar: [$var] from KeyVault" -ForegroundColor Blue
            $secret = (Get-AzKeyVaultSecret -VaultName "kv-internal-idam-$EnvName" -Name $var).SecretValue
        } catch {
            throw $_.Exception.Message
        }

        $plain = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($secret))
        
        switch ($var) {
            "TerraformAppClientId" { $ENV:ARM_CLIENT_ID = $plain }
            "TerraformClientSecret" { $ENV:ARM_CLIENT_SECRET = $plain}
            "TerraformSubscriptionId" { $ENV:ARM_SUBSCRIPTION_ID = $plain}
            "TerraformTenantId" { $ENV:ARM_TENANT_ID = $plain}
            default           { Write-Host "No secret was found for $var" -ForegroundColor Red }
        }
    }
}

Set-EnvironmentVariables -EnvVars $envVars -EnvName $EnvName
