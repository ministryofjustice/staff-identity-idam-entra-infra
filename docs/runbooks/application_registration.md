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
    display_name                 = "EUCS IDAM App Reg Test 1"
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

    graph_delegated_permissions = ["User.Read"]
    graph_application_permissions  = []

    allowed_groups = ["MoJO - Users - All"]

    create_access_package = false
    app_roles                    = []
}
```

### Single Sign On Application with App Roles for Authorisation Setup

To create a Application Registration that will allow your application to use Entra ID as its Authentication provider and handle Authorisation via App Roles and Access Packages, you can use the following code.

For more information on App Roles, Access Packages and how to consume these in your application, read the following Microsoft Guidance.

- [https://learn.microsoft.com/en-us/entra/identity-platform/howto-add-app-roles-in-apps](https://learn.microsoft.com/en-us/entra/identity-platform/howto-add-app-roles-in-apps)

```
eucs_idam_tf_test_app_reg = {
    display_name                 = "EUCS IDAM App Reg Test 2 (App Roles)"
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

    graph_delegated_permissions = ["User.Read"]
    graph_application_permissions  = []

    allowed_groups = ["MoJO - Users - All"]

    create_access_package = true
    access_package_reviewers = {
        devl = ["xxx.xxx@devl.justice.gov.uk", "xxx.xxx@devl.justice.gov.uk"]
        nle  = ["xxx.xxx@test.justice.gov.uk", "xxx.xxx@test.justice.gov.uk"]
        live = ["xxx.xxx@justice.gov.uk", "xxx.xxx@justice.gov.uk"]
    }
    app_roles = [
        {
            allowed_member_types = ["User"]
            description          = "ReadOnly roles have limited query access"
            display_name         = "ReadOnly"
            id                   = "${random_uuid.eucs_idam_tf_test_app_reg2_readonly.result}"
            value                = "User"
            access_package_hidden = false
        },
        {
            allowed_member_types = ["User"]
            description          = "Administrator roles"
            display_name         = "Administrator"
            id                   = "${random_uuid.eucs_idam_tf_test_app_reg2_admin.result}"
            value                = "Admin"
            access_package_hidden = true
        }
    ]
}
```

### GitHub Federated Identity Credentials (Workload Identity)

This feature allows you to create a trust relationship between GitHub and Entra ID to use a workload identity via OIDC for authentication rather than managing client secrets or certificates. For GitHub pipelines that require access to Azure or Entra ID resources, this provides a managed and secure way of maintaining a connection.

> This only works for repositories within the `ministryofjustice` GitHub Organisation.

Further information on Workload Identities and Federated Identity Credentials for GitHub can be found here [https://learn.microsoft.com/en-gb/entra/workload-id/workload-identity-federation](https://learn.microsoft.com/en-gb/entra/workload-id/workload-identity-federation).

To use the Federated Managed Identity in GitHub, see the following article [https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure-openid-connect](https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure-openid-connect).

```
eucs_idam_tf_app_reg_fed_identitity = {
    department_name              = "eucs"
    ...

    federated_identity_credentials = [
        {
            repo_name      = "staff-identity-idam-entra-infra"
            display_name   = "staff-identity-idam-entra-infra-branch"
            description    = "Example federated credential to staff-identity-idam-entra-infra branch example-federated."
            subject_suffix = "ref:refs/heads/example-federated"
        },
        {
            repo_name      = "staff-identity-idam-entra-infra"
            display_name   = "staff-identity-idam-entra-infra-environment"
            description    = "Example federated credential to staff-identity-idam-entra-infra Environment example-federated."
            subject_suffix = "environment:example-federated"
        },
        {
            repo_name      = "staff-identity-idam-entra-infra"
            display_name   = "staff-identity-idam-entra-infra-tags"
            description    = "Example federated credential to staff-identity-idam-entra-infra Tag example-federated."
            subject_suffix = "ref:refs/tags/example-federated"
        },
        {
            repo_name      = "staff-identity-idam-entra-infra"
            display_name   = "staff-identity-idam-entra-infra-pull-request"
            description    = "Example federated credential to staff-identity-idam-entra-infra pull requests."
            subject_suffix = "pull_request"
        }
    ]
    ...
}
```

## Argument Reference

| Property Name                    | Description                                                                                                                                                                                                                                                                 | Example                                                                       |
| -------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| `display_name`                   | Friendly display name of the Application.                                                                                                                                                                                                                                   | `display_name = "EUCS IDAM App Reg Test 2 (App Roles)"`                       |
| `department_name`                | Department name such as EUCS, OPG, LAA, etc.                                                                                                                                                                                                                                | `department_name = "eucs"`                                                    |
| `team_name`                      | Team name acronym such as IDAM, MWP, AP, etc.                                                                                                                                                                                                                               | `team_name = "idam"`                                                          |
| `application_name`               | Application name Application Registration refers to such as ServiceNow, Slack, Ml-Flow, Intranet, etc.                                                                                                                                                                      | `application_name = "app-reg-2"`                                              |
| `notes`                          | Description of the applications purpose and any further information to help identify the use case of the application.                                                                                                                                                       | `notes = "SSO Application for internal CMS Custom Web Application"`           |
| `service_management_reference`   | If relevant, a JIRA, ServiceNow or similar reference number to help tracking of this integration.                                                                                                                                                                           | `service_management_reference = "SCTASK0000123"`                              |
| `owners_devl`                    | Owners that are assignable on the DEVL tenant. There should be at least two owners and these will be your DEVL account UPNs.                                                                                                                                                | `["xxx.xxx@devl.justice.gov.uk", "xxx.xxx@devl.justice.gov.uk"]`              |
| `owners_nle`                     | Owners that are assignable on the NLE tenant. There should be at least two owners and these will be your NLE account UPNs.                                                                                                                                                  | `["xxx.xxx@test.justice.gov.uk", "xxx.xxx@test.justice.gov.uk"]`              |
| `owners_live`                    | Owners that are assignable on the LIVE tenant. There should be at least two owners and these should be either shared mailbox users or your teams `@justice.gov.uk` UPNs.                                                                                                    | `["xxx.xxx@justice.gov.uk", "xxx.xxx@justice.gov.uk"]`                        |
| `homepage_url`                   | The URL to this application’s home page or the URL where users can sign-in and use this application.                                                                                                                                                                        | `homepage_url = "https://example.com"`                                        |
| `logout_url`                     | Where we send a request to have the application clear the user's session data. This is required for single sign-out to work correctly.                                                                                                                                      | `logout_url = "https://example.com/logout"`                                   |
| `redirect_uris`                  | The URIs we will accept as destinations when returning authentication responses (tokens) after successfully authenticating or signing out users. The redirect URI you send in the request to the login server should match one listed here. Also referred to as reply URLs. | `redirect_uris = ["https://example.com/account"]`                             |
| `tenants_required`               | Which tenants you want this application to be available on. For testing you may initially only require DEVL to be setup and subsequent Pull Requests can release to other tenants. This is a list of strings, "DEVL", "NLE" and "LIVE".                                     | `tenants_required = ["DEVL", "NLE", "LIVE"]`                                  |
| `application_template_name`      | Builds an Enterprise Application from a build in Microsoft Template.                                                                                                                                                                                                        | `application_template_name = "Google Cloud / G Suite Connector by Microsoft"` |
| `graph_application_permissions`  | Graph Application Permissions required on the Application such as `User.Read.All`.                                                                                                                                                                                          | `graph_application_permissions = ["User.Read.All"]`                           |
| `graph_delegated_permissions`    | Graph Delegated Permissions required on the Application such as `User.Read`.                                                                                                                                                                                                | `graph_delegated_permissions = ["User.Read"]`                                 |
| `allowed_groups`                 | (Optional) List of Security Groups to manage access for people to the application.                                                                                                                                                                                          | `allowed_groups = ["MoJO - Users - All"]`                                     |
| `create_access_package`          | Create access packages for managing user access to your application. This requires App Roles to be setup.                                                                                                                                                                   | `create_access_package = true`                                                |
| `access_package_reviewers`       | Assign your business user reviewers who will grant, deny and review access to the application and roles assigned.                                                                                                                                                           | See example above                                                             |
| `app_roles`                      | App roles are custom roles to assign permissions to users or apps. The application defines and publishes the app roles and interprets them as permissions during authorization.                                                                                             | See table below                                                               |
| `federated_identity_credentials` | Manages a federated identity credential associated with an application within Azure Active Directory.                                                                                                                                                                       | See table below                                                               |

### App Roles

| Property Name           | Description                                                                                                                                       | Example                                                            |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------ |
| `allowed_member_types`  | What type of objects can be assigned to this role.                                                                                                | `allowed_member_types = ["User"]`                                  |
| `description`           | Description of this role.                                                                                                                         | `description = "ReadOnly roles have limited query access"`         |
| `display_name`          | Display name for this role.                                                                                                                       | `display_name = "ReadOnly"`                                        |
| `id`                    | UUID associated with the role. This is defined first in [../../terraform/app-role-uuids.tf](../../terraform/app-role-uuids.tf) and assigned here. | `id = "${random_uuid.eucs_idam_tf_test_app_reg2_readonly.result}"` |
| `value`                 | Value that will be passed in the users authentication token if assigned.                                                                          | `value = "User"`                                                   |
| `access_package_hidden` | Should the Access Package be visible for all users to request access.                                                                             | `access_package_hidden = false`                                    |

### Federated Identity Credentials

| Property Name    | Description                            | Example                                                                                          |
| ---------------- | -------------------------------------- | ------------------------------------------------------------------------------------------------ |
| `repo_name`      | The name of your repository in GitHub. | `repo_name = "staff-identity-idam-entra-infra"`                                                  |
| `display_name`   | The display name of your credential.   | `display_name = "staff-identity-idam-entra-infra-pull-request"`                                  |
| `description`    | Description of this role.              | `description = "Example federated credential to staff-identity-idam-entra-infra pull requests."` |
| `subject_suffix` | Display name for this role.            | `subject_suffix = "pull_request"`                                                                |
