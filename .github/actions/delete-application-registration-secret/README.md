# Delete Entra ID Application Registration Secret Rotation

A Github Action to delete a secret. The Github Action can be run on a schedule, against PRs or on a merge to main.

## Pre-requisites

In order for Github Actions to have permission, the IDAM Team must first set up a `Federation credential` with your Application Registration and your Github repository.

Depending on the scenario of how you want to mange the rotation of your secrets (on pull requests, on merge to main, on a schedule, etc), the IDAM Team will need to configure your `Federation credential` appropriately.

Once connected, you will need to set your `Client/Application ID` and `Tenant ID` as secrets in Github to be referenced by the Github Action.

## Inputs

* client-id - The client/application id of the Application Registration that is subject to secret rotation.
* secret-id - The ID of the secret generated

## Example

Create a file in your repo called `.github/workflows/app-registration-delete-secret.yml` with the following contents:

```
name: "Delete Secret"
on:
  workflow_dispatch:
  pull_request:

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
      uses: ./.github/actions/delete-application-registration-secret
      id: delete-secret
      with:
        client-id: ${{ secrets.AZURE_CLIENT_ID }}
        secret-id: ${{ env.SECRET_ID }}
```
