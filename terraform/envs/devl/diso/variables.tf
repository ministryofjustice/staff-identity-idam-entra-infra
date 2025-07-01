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
    mobile_desktop_redirect_uris = list(string)
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
    "diso-networks-engineers-graph-permissions" = {
      notes                          = "Used to grant access to Graph API scopes"
      service_management_reference   = "IDAM-1811"
      display_name                   = "MOJO-DISO-Networks-Engineers-Graph-Permissions"
      department_name                = "DISO"
      team_name                      = "Networks"
      application_name               = "MoJ-OFFICIAL-Devl-Spoke-EUCSVD01-TF"
      create_access_package          = false
      access_package_reviewers       = []
      owners                         = []      
      allowed_groups                 = []
      homepage_url                   = null
      logout_url                     = null
      redirect_uris                  = null
      mobile_desktop_redirect_uris   = null
      app_roles                      = []
      graph_application_permissions  = []
      graph_delegated_permissions    = []
      tenants_required               = ["DEVL"]
      federated_identity_credentials = []
      service_principle = {
        login_url                     = null
        notification_email_addresses  = []
        preferred_single_sign_on_mode = null
        app_role_assignment_required  = true
        account_enabled               = true
        application_template_name     = null
        hide                          = true
      }
      identifier_uris = null
    },
    "diso-networks-vv-graph-permissions" = {
      notes                          = "Used to grant access to Graph API scopes"
      service_management_reference   = "IDAM-1811"
      display_name                   = "MOJO-DISO-VV-Graph-Permissions"
      department_name                = "DISO"
      team_name                      = "Video and Voice"
      application_name               = "MOJO-DISO-VV-Graph-PermissionsF"
      create_access_package          = false
      access_package_reviewers       = []
      owners                         = []      
      allowed_groups                 = []
      homepage_url                   = null
      logout_url                     = null
      redirect_uris                  = null
      mobile_desktop_redirect_uris   = null
      app_roles                      = []
      graph_application_permissions  = []
      graph_delegated_permissions    = []
      tenants_required               = ["DEVL"]
      federated_identity_credentials = []
      service_principle = {
        login_url                     = null
        notification_email_addresses  = []
        preferred_single_sign_on_mode = null
        app_role_assignment_required  = true
        account_enabled               = true
        application_template_name     = null
        hide                          = true
      }
      identifier_uris = null
    },
    "diso-networks-vmrt-graph-permissions" = {
      notes                          = "Used to grant access to Graph API scopes"
      service_management_reference   = "IDAM-1811"
      display_name                   = "MOJO-DISO-VV-Graph-Permissions"
      department_name                = "DISO"
      team_name                      = "Video for Microsoft Teams Rooms and Digital Signage Engineers"
      application_name               = "MOJO-DISO-VV-Graph-PermissionsF"
      create_access_package          = false
      access_package_reviewers       = []
      owners                         = []      
      allowed_groups                 = []
      homepage_url                   = null
      logout_url                     = null
      redirect_uris                  = null
      mobile_desktop_redirect_uris   = null
      app_roles                      = []
      graph_application_permissions  = []
      graph_delegated_permissions    = []
      tenants_required               = ["DEVL"]
      federated_identity_credentials = []
      service_principle = {
        login_url                     = null
        notification_email_addresses  = []
        preferred_single_sign_on_mode = null
        app_role_assignment_required  = true
        account_enabled               = true
        application_template_name     = null
        hide                          = true
      }
      identifier_uris = null
    },"diso-networks-vmrt-graph-permissions" = {
      notes                          = "Used to grant access to Graph API scopes"
      service_management_reference   = "IDAM-1811"
      display_name                   = "MOJO-DISO-HostedVoice-Graph-Permissions"
      department_name                = "DISO"
      team_name                      = "HostedVoice"
      application_name               = "MOJO-DISO-HostedVoice-Graph-Permissions"
      create_access_package          = false
      access_package_reviewers       = []
      owners                         = []      
      allowed_groups                 = []
      homepage_url                   = null
      logout_url                     = null
      redirect_uris                  = null
      mobile_desktop_redirect_uris   = null
      app_roles                      = []
      graph_application_permissions  = []
      graph_delegated_permissions    = []
      tenants_required               = ["DEVL"]
      federated_identity_credentials = []
      service_principle = {
        login_url                     = null
        notification_email_addresses  = []
        preferred_single_sign_on_mode = null
        app_role_assignment_required  = true
        account_enabled               = true
        application_template_name     = null
        hide                          = true
      }
      identifier_uris = null
    }
  }
}
