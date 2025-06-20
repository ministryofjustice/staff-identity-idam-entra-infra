variable "location" {
  description = "Azure region for resources to be deployed to."
  type        = string
  default     = "uksouth"
}

variable "applications" {
  description = "Map of application details"
  type = map(object({
    notes                        = string
    service_management_reference = string
    display_name                 = string
    department_name              = string
    team_name                    = string
    application_name             = string
    create_access_package        = bool
    access_package_reviewers     = list(string)
    owners                       = list(string)
    allowed_groups               = list(string)
    homepage_url                 = string
    logout_url                   = string
    redirect_uris                = list(string)
    app_roles = list(object({
      allowed_member_types  = list(string)
      description           = string
      display_name          = string
      id                    = string
      value                 = string
      access_package_hidden = bool
    }))
    graph_application_permissions = list(string)
    graph_delegated_permissions   = list(string)
    tenants_required              = list(string)
    federated_identity_credentials = list(object({
      repo_name      = string
      display_name   = string
      description    = string
      subject_suffix = string
    }))
    service_principle = object({
      login_url                     = string
      notification_email_addresses  = list(string)
      preferred_single_sign_on_mode = string
      app_role_assignment_required  = bool
      account_enabled               = bool
      application_template_name     = string
      hide                          = bool
    })
    identifier_uris = list(string)
  }))
  default = {
    "diso_teams_routing" = {
      notes                          = "EUCS VDS Packer used for creating VM Images, via Packer"
      service_management_reference   = "IDAM-2685"
      display_name                   = "MoJ-OFFICIAL-Prod-EUCS-VDS-Packer"
      department_name                = "EUCS-CORE-AVD"
      team_name                      = "EUCS-CORE-Infrastructure-AVD"
      application_name               = "MoJ-OFFICIAL-Prod-EUCS-VDS-Packer"
      create_access_package          = false
      access_package_reviewers       = []
      owners                         = ["Lee.Parkerwalsh@justiceuk.onmicrosoft.com", "David.Close@JusticeUK.onmicrosoft.com", "Dragan.letic1@JusticeUK.onmicrosoft.com", "Ian.Hegarty@JusticeUK.onmicrosoft.com", "Paul.Colegate@JusticeUK.onmicrosoft.com", "Michael.Kirkpatrick@JusticeUK.onmicrosoft.com"]
      allowed_groups                 = []
      homepage_url                   = null
      logout_url                     = null
      redirect_uris                  = null
      app_roles                      = []
      graph_application_permissions  = []
      graph_delegated_permissions    = []
      tenants_required               = ["LIVE"]
      federated_identity_credentials = []
      service_principle = {
        login_url                     = null
        notification_email_addresses  = []
        preferred_single_sign_on_mode = null
        app_role_assignment_required  = true
        account_enabled               = true
        application_template_name     = null
        hide                          = null
      }
      identifier_uris = null
    },
    "vds_subscription_automation_01" = {
      notes                          = "Used for Terraform automation activities in VDS subscriptions"
      service_management_reference   = "IDAM-3367"
      display_name                   = "MoJ-OFFICIAL-Prod-Spoke-EUCSVD01-TF"
      department_name                = "EUCS-CORE-AVD"
      team_name                      = "EUCS-CORE-Infrastructure-AVD"
      application_name               = "MoJ-OFFICIAL-Prod-Spoke-EUCSVD01-TF"
      create_access_package          = false
      access_package_reviewers       = []
      owners                         = ["David.Close@JusticeUK.onmicrosoft.com", "Dragan.letic1@JusticeUK.onmicrosoft.com", "Ian.Hegarty@JusticeUK.onmicrosoft.com", "Michael.Kirkpatrick@JusticeUK.onmicrosoft.com", "Paul.Colegate@JusticeUK.onmicrosoft.com"]
      allowed_groups                 = []
      homepage_url                   = null
      logout_url                     = null
      redirect_uris                  = null
      app_roles                      = []
      graph_application_permissions  = ["Directory.Read.All", "User.Read.All", "Group.Create", "Group.ReadWrite.All"]
      graph_delegated_permissions    = []
      tenants_required               = ["LIVE"]
      federated_identity_credentials = []
      service_principle = {
        login_url                     = null
        notification_email_addresses  = []
        preferred_single_sign_on_mode = null
        app_role_assignment_required  = true
        account_enabled               = true
        application_template_name     = null
        hide                          = null
      }
      identifier_uris = null
    },
    "vds_subscription_automation_02" = {
      notes                          = "Used for Terraform automation activities in VDS subscriptions"
      service_management_reference   = "IDAM-3367"
      display_name                   = "MoJ-OFFICIAL-Prod-Spoke-EUCSVD02-TF"
      department_name                = "EUCS-CORE-AVD"
      team_name                      = "EUCS-CORE-Infrastructure-AVD"
      application_name               = "MoJ-OFFICIAL-Prod-Spoke-EUCSVD02-TF"
      create_access_package          = false
      access_package_reviewers       = []
      owners                         = ["David.Close@JusticeUK.onmicrosoft.com", "Dragan.letic1@JusticeUK.onmicrosoft.com", "Ian.Hegarty@JusticeUK.onmicrosoft.com", "Michael.Kirkpatrick@JusticeUK.onmicrosoft.com", "Paul.Colegate@JusticeUK.onmicrosoft.com"]
      allowed_groups                 = []
      homepage_url                   = null
      logout_url                     = null
      redirect_uris                  = null
      app_roles                      = []
      graph_application_permissions  = ["Directory.Read.All", "User.Read.All", "Group.Create", "Group.ReadWrite.All"]
      graph_delegated_permissions    = []
      tenants_required               = ["LIVE"]
      federated_identity_credentials = []
      service_principle = {
        login_url                     = null
        notification_email_addresses  = []
        preferred_single_sign_on_mode = null
        app_role_assignment_required  = true
        account_enabled               = true
        application_template_name     = null
        hide                          = null
      }
      identifier_uris = null
    },
    "MoJ-OFFICIAL-DEVL-EUCS-VDS-Housekeeping" = {
      notes                          = "Used for Terraform automation activities in VDS subscriptions"
      service_management_reference   = "IDAM-3365"
      display_name                   = "MoJ-OFFICIAL-Prod-EUCS-VDS-Housekeeping"
      department_name                = "EUCS-CORE-AVD"
      team_name                      = "EUCS-CORE-Infrastructure-AVD"
      application_name               = "MoJ-OFFICIAL-Prod-EUCS-VDS-Housekeeping"
      create_access_package          = false
      access_package_reviewers       = []
      owners                         = ["David.Close@JusticeUK.onmicrosoft.com", "Dragan.letic1@JusticeUK.onmicrosoft.com", "Ian.Hegarty@JusticeUK.onmicrosoft.com", "Michael.Kirkpatrick@JusticeUK.onmicrosoft.com", "Paul.Colegate@JusticeUK.onmicrosoft.com"]
      allowed_groups                 = []
      homepage_url                   = null
      logout_url                     = null
      redirect_uris                  = null
      app_roles                      = []
      graph_application_permissions  = ["Application.Read.All"]
      graph_delegated_permissions    = []
      tenants_required               = ["LIVE"]
      federated_identity_credentials = []
      service_principle = {
        login_url                     = null
        notification_email_addresses  = []
        preferred_single_sign_on_mode = null
        app_role_assignment_required  = true
        account_enabled               = true
        application_template_name     = null
        hide                          = null
      }
      identifier_uris = null
    }
  }
}
