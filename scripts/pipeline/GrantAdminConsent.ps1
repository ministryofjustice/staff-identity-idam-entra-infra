[CmdletBinding()]
param (
    [String]$OutFilePath = "./tfplan.out"
)

Write-Host "Outputting TFplan to JSON" -ForegroundColor Yellow
terraform show -json $OutFilePath | Out-File -Encoding utf8 tfplan.json

$json = Get-Content tfplan.json | ConvertFrom-Json 

# Check for azuread_application creation
$createdApps = $json.resource_changes | Where-Object {
    $_.type -eq "azuread_application" -and $_.change.actions -contains "create"
}

if ($createdApps) {
    Write-Host "✅ New Azure AD app detected."
    $env:NEW_AAD_APP = "true"
} else {
    Write-Host "🟡 No new Azure AD apps created."
    $env:NEW_AAD_APP = "false"
}
