# Managing Application Registrations

## Overview

You can manage your Application Registration setup from the file [../../terraform/data.application-registrations.tf](../../terraform/data.application-registrations.tf).

To create a new one you can add a new unique key under `app_registration_list` and supply the appropriate properties and values to configure your application.

Once complete you can raise a Pull Request which the IDAM team will review and process further.

## Example Usage

Below are a few examples of how this can be setup.

### Single Sign On Application Setup

To create a Application Registration that will allow your application to use Entra ID as its Authentication provider, you can use the following code.

```
eucs_idam_tf_test_app_reg = {
    department_name              = "eucs"
    team_name                    = "idam"
    application_name             = "app-reg"
    notes                        = "Test IDAM Team SSO Application for integration from test application."
    service_management_reference = "SCTASK0000123"
    owners_devl                  = ["xxx.xxx@devl.justice.gov.uk", "xxx.xxx@devl.justice.gov.uk"]
    owners_nle                   = ["xxx.xxx@test.justice.gov.uk", "xxx.xxx@test.justice.gov.uk"]
    owners_live                  = ["xxx.xxx@justice.gov.uk", "xxx.xxx@justice.gov.uk"]
    homepage_url                 = "https://example.com"
    logout_url                   = "https://example.com/logout"
    redirect_uris                = ["https://example.com/account"]
    tenants_required             = ["DEVL", "NLE", "LIVE"]

    required_resource_access_scopes = ["User.Read"]
    required_resource_access_roles  = []

    allowed_groups = ["MoJO - Users - All"]

    create_access_package = false
    app_roles                    = []
}
```

### Single Sign On Application with App Roles for Authorisation Setup

To create a Application Registration that will allow your application to use Entra ID as its Authentication provider and handle Authorisation via App Roles and Access Packages, you can use the following code.

For more information on App Roles, Access Packages and how to consume these in your application, read the following Microsoft Guidance.

* [https://learn.microsoft.com/en-us/entra/identity-platform/howto-add-app-roles-in-apps](https://learn.microsoft.com/en-us/entra/identity-platform/howto-add-app-roles-in-apps)

```
eucs_idam_tf_test_app_reg = {
    department_name              = "eucs"
    team_name                    = "idam"
    application_name             = "app-reg"
    notes                        = "Test IDAM Team SSO Application for integration from test application."
    service_management_reference = "SCTASK0000123"
    owners_devl                  = ["xxx.xxx@devl.justice.gov.uk", "xxx.xxx@devl.justice.gov.uk"]
    owners_nle                   = ["xxx.xxx@test.justice.gov.uk", "xxx.xxx@test.justice.gov.uk"]
    owners_live                  = ["xxx.xxx@justice.gov.uk", "xxx.xxx@justice.gov.uk"]
    homepage_url                 = "https://example.com"
    logout_url                   = "https://example.com/logout"
    redirect_uris                = ["https://example.com/account"]
    tenants_required             = ["DEVL", "NLE", "LIVE"]

    required_resource_access_scopes = ["User.Read"]
    required_resource_access_roles  = []

    allowed_groups = ["MoJO - Users - All"]

    create_access_package = false
    create_access_package = true
    app_roles = [
        {
            allowed_member_types = ["User"]
            description          = "ReadOnly roles have limited query access"
            display_name         = "ReadOnly"
            id                   = "${random_uuid.eucs_idam_tf_test_app_reg2_readonly.result}"
            value                = "User"
        },
        {
            allowed_member_types = ["User"]
            description          = "Administrator roles"
            display_name         = "Administrator"
            id                   = "${random_uuid.eucs_idam_tf_test_app_reg2_admin.result}"
            value                = "Admin"
        }
    ]
}
```

## Argument Reference

| Property Name | Description | Example |
| --- | --- | --- |
| `department_name` | Department name such as EUCS, OPG, LAA, etc. | `department_name = "eucs"` |
| `team_name` | Team name acronym such as IDAM, MWP, AP, etc. | `team_name = "idam"` |
| `application_name` | Application name Application Registration refers to such as ServiceNow, Slack, Ml-Flow, Intranet, etc. | `application_name = "app-reg-2"` |
| `notes` | Description of the applications purpose and any further information to help identify the use case of the application. | `notes = "SSO Application for internal CMS Custom Web Application"` |
| `service_management_reference` | If relevant, a JIRA, ServiceNow or similar reference number to help tracking of this integration. | `service_management_reference = "SCTASK0000123"` |
| `owners_devl` | Owners that are assignable on the DEVL tenant. There should be at least two owners and these will be your DEVL account UPNs. | `["xxx.xxx@devl.justice.gov.uk", "xxx.xxx@devl.justice.gov.uk"]` |
| `owners_nle` | Owners that are assignable on the NLE tenant. There should be at least two owners and these will be your NLE account UPNs. | `["xxx.xxx@test.justice.gov.uk", "xxx.xxx@test.justice.gov.uk"]` |
| `owners_live` | Owners that are assignable on the LIVE tenant. There should be at least two owners and these should be either shared mailbox users or your teams `@justice.gov.uk` UPNs. | `["xxx.xxx@justice.gov.uk", "xxx.xxx@justice.gov.uk"]` |
| `homepage_url` | The URL to this application’s home page or the URL where users can sign-in and use this application. | `homepage_url = "https://example.com"` |
| `logout_url` | Where we send a request to have the application clear the user's session data. This is required for single sign-out to work correctly. | `logout_url = "https://example.com/logout"` |
| `redirect_uris` | The URIs we will accept as destinations when returning authentication responses (tokens) after successfully authenticating or signing out users. The redirect URI you send in the request to the login server should match one listed here. Also referred to as reply URLs. | `redirect_uris = ["https://example.com/account"]` |
| `tenants_required` | Which tenants you want this application to be available on. For testing you may initially only require DEVL to be setup and subsequent Pull Requests can release to other tenants. This is a list of strings, "DEVL", "NLE" and "LIVE". | `tenants_required = ["DEVL", "NLE", "LIVE"]` |
| `required_resource_access_roles` | Graph Application Permissions required on the Application such as `User.Read.All`. | `required_resource_access_roles = ["User.Read.All"]` |
| `required_resource_access_scopes` | Graph Delegated Permissions required on the Application such as `User.Read`. | `required_resource_access_scopes = ["User.Read"]` |
| `allowed_groups` | (Optional) List of Security Groups to manage access for people to the application. | `allowed_groups = ["MoJO - Users - All"]` |
| `create_access_package` | Create access packages for managing user access to your application. This requires App Roles to be setup. | `create_access_package = true` |
| `app_roles` | App roles are custom roles to assign permissions to users or apps. The application defines and publishes the app roles and interprets them as permissions during authorization. | See table below |

### App Roles

| Property Name | Description | Example |
| --- | --- | --- |
| `allowed_member_types` | What type of objects can be assigned to this role. | `allowed_member_types = ["User"]` |
| `description` | Description of this role. | `description = "ReadOnly roles have limited query access"` |
| `display_name` | Display name for this role. | `display_name = "ReadOnly"` |
| `id` | UUID associated with the role. This is defined first in [../../terraform/app-role-uuids.tf](../../terraform/app-role-uuids.tf) and assigned here. | `id = "${random_uuid.eucs_idam_tf_test_app_reg2_readonly.result}"` |
| `value` | Value that will be passed in the users authentication token if assigned. | `value = "User"` |
