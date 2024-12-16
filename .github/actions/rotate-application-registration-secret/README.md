# Entra ID Application Registration Secret Rotation

A Github Action to rotate a secret and return the new value. The Github Action can be run on a schedule, against PRs or on a merge to main.

It will also automatically delete any expired credentials on each run.

## Pre-requisites

In order for Github Actions to have permission to rotate credentials, the IDAM Team must first set up a `Federation credential` with your Application Registration and your Github repository.

Depending on the scenario of how you want to mange the rotation of your secrets (on pull requests, on merge to main, on a schedule, etc), the IDAM Team will need to configure your `Federation credential` appropriately.

Once connected, you will need to set your `Client/Application ID` and `Tenant ID` as secrets in Github to be referenced by the Github Action.

## Inputs

* secret-validity-in-days - Desired validity, in days, of the new secret. The default is 90 days.

## Outputs

* new-secret - The newly generated secret for the provided service principal

## Example

Create a file in your repo called `.github/workflows/app-registration-rotate-secret.yml` with the following contents:

```
name: "Rotate Secret"
on:
  workflow_dispatch:

permissions:
  id-token: write
  contents: read
      
jobs: 
  login-and-rotate:
    runs-on: ubuntu-latest
    steps:        
    - uses: actions/checkout@v4
    - name: 'Az CLI login with Federation credential'
      uses: azure/login@v2
      with:
        client-id: ${{ secrets.AZURE_CLIENT_ID }}
        tenant-id: ${{ secrets.AZURE_TENANT_ID }}          
        allow-no-subscriptions: true        
    - name: 'Rotate Application secret'
      uses: ./.github/actions/rotate-application-registration-secret/action.yaml
      id: rotate-secret
      with:
        secret-validity-in-days: 30
    - name: Use the new secret    
      run: |
        echo "${{ steps.rotate-secret.outputs.new-secret }}"
```
