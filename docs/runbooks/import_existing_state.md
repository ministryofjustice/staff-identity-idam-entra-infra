# Import existing Application Registration

If you are required to import the existing state of a resource not managed via terraform, you can folow these steps.

## Environment Variables

In your terminal, run each of these commands replacing the empty guids with the appropriate values. This provides the values for terraform to access Entra.

``` bash
$Env:ARM_TENANT_ID = "00000000-0000-0000-0000-000000000000"
$Env:ARM_SUBSCRIPTION_ID = "00000000-0000-0000-0000-000000000000"
$Env:ARM_CLIENT_ID = "00000000-0000-0000-0000-000000000000"
$Env:ARM_CLIENT_SECRET = "00000000-0000-0000-0000-000000000000"
```

## Initialise Terraform locally

Navigate to the directory you want to manage. 

e.g. `idam-testing` in `NLEExternal`

`cd terraform/envs/nleexternal/idam-testing`

Run the following command to initialise Terraform.

`terraform init -backend-config="state.config"`

## Import state

To import a Application Registration and Service Principle you can use the following exmaples replacing the empty guids with the `ObjectID` of each resource. Also update `application_name` to what the application will be called in your `variables.tf` file.

`terraform import 'module.application-registration["application_name"].azuread_application.entra_app_reg' /applications/00000000-0000-0000-0000-000000000000`

`terraform import 'module.application-registration["application_name"].azuread_service_principal.entra_app_service_principle' /servicePrincipals/00000000-0000-0000-0000-000000000000`

## Check for changes

Once the state has been imported you can run `terraform plan`. You will then be required to adjust the `variables.tf` file to match the existing state.

## Remove state

If you need to roll back or need to remove the state from Terraform so it becomes unmanaged, you can run the following commands replacing the empty guids with the `ObjectID` and `application_name` of each resource.


`terraform state rm 'module.application-registration["application_name"].azuread_service_principal.entra_app_service_principle'`

`terraform state rm 'module.application-registration["application_name"].azuread_application.entra_app_reg'`
