# Application Roles for Authorisation

## Overview

As well as using Entra ID for your Authentication, you can also take advantage of App Roles and Access Packages to manage your integrating applications Authorisation.

Managing users this way over Security Groups or custom Authorisation layers in your application have multiple advantages

* JML processes will automatically remove access from your application when a user is deleted within Entra ID
* Approvals are handled through the Microsoft My Access portal requiring user authentication before assignment
* Audit trail of access requests
* Automated Access Reviews to ensure users have the right access
* Integration with wider Azure and Entra permissions and groups for automated assignment (future)

This document provides an overview of how this works and setup to enable this functionality.

To learn more about Access Packages and App Roles, use the following links.

[Add app roles to your application and receive them in the token](https://learn.microsoft.com/en-us/entra/identity-platform/howto-add-app-roles-in-apps)

## Setting up an Application Registration with App Roles and Access Package management

You are first requried to create a new Application Registration like the example below. For more details on each property, see the [Application Registration Runbook](./application_registration.md).

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

    allowed_groups = []

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

The two key properties to enable App Roles and Access Packages are

* `create_access_package`
* `access_package_reviewers`
* `app_roles/access_package_hidden`
* `app_roles`
* `owners_devl-nle-live`

You must ensure `create_access_package` is set to `true` and you have defined the relevant `app_roles`. The `access_package_reviewers` will be set as the Access Package maintainers and will be responsible for the maintenance of authorised users. This will allow those users to manage users who have access to the application.

You can create any number of `app_roles` that users can be assigned too. Users can also belong to more than 1 App Role at any one time.

Once you have defined your roles and your Pull Request has been merged, you will be able to manage users in the Microsoft My Access page. If you do not want your Access Package to be visible in the My Access portal by default, you can se `access_package_hidden` to `true`. The IDAM team will provide you with a direct url you can send to those you want to be able to request access instead.

> Note: There is currently a limitation with the Azure API which prevents the automation of assigning a Application Registration to an Access Package. Once the Pull Request has been merged, a member of the IDAM team will assign this manually to ensure you can manage users.

## Managing App Roles via Access Packages

Now you have your Application Registration setup with defined App Roles and associated Access Packages, you can use the Microsoft My Access page.

### Get link for new user to be assigned to Access Package/Role

* Go to [https://myaccess.microsoft.com/](https://myaccess.microsoft.com/)
* Sign in with your justice identity
* Click on `Access packages`
* Find the relevant package for the role required and click the row
* In the popup click `Copy link`
* Send this link to the user who would like access

### Approving a new request

* Go to [https://myaccess.microsoft.com/](https://myaccess.microsoft.com/)
* Sign in with your justice identity
* Click on `Approvals`
* Select the user requesting access and choose `Approve` or `Deny`

### Access Reviews

Every 6 months you will be required to do a review of users who have access to the Access Packages you own and the roles they hold. This is all done through the [Microsoft My Access portal](https://myaccess.microsoft.com/).

When you recieve an email indicating it is time for a review, you can analyse and confirm the users of your application. This is an opportunity to remove unneeded access to your applications to increase your security posture.
