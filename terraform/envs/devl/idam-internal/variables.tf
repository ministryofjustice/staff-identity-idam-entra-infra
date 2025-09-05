variable "location" {
  description = "Azure region for resources to be deployed to."
  type        = string
  default     = "uksouth"
}


variable "engineer_object_ids" {
  type = map(string)
  default = {
    "jason"   = "b72b2e71-8c47-4719-b5f2-029bb6eb880a"
    "luciano" = "2de04ee5-efd9-4bae-93fe-1f5b324d4a85"
    "mike"    = "efecd6df-2a50-4cf0-b01f-b92a8b4298f9"
    "abarna"  = "b6bae8b3-cb82-4449-8f69-d5bd55ba253e"
    "matt"    = "670ea5cf-11d7-492b-978f-28ca56734359"
    "davidH"  = "7e414e00-5549-4ceb-b9e7-2bcf0fa93188"
    "davidS"  = "2cd45b2f-6611-4984-afd0-4de25a0f1272"
    "lee"     = "6301a51f-1867-4ca0-8abe-cf3a8ea56b0c"
    "john"    = "02acc612-0cc1-4231-a44d-b1bbfcd132f7"
  }
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
    "eucs-idam-test" = {
      notes                          = "Test app reg"
      service_management_reference   = "IDAM-4098"
      display_name                   = "MOJO-EUCS-IDAM-Test"
      department_name                = "Justice-Digital"
      team_name                      = "EUCS-IDAM"
      application_name               = "MOJO-EUCS-IDAM-Test"
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
    "eucs-idam-test2" = {
      notes                          = "Test app reg2"
      service_management_reference   = "IDAM-4098"
      display_name                   = "MOJO-EUCS-IDAM-Test2"
      department_name                = "Justice-Digital"
      team_name                      = "EUCS-IDAM"
      application_name               = "MOJO-EUCS-IDAM-Test2"
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
    "eucs-idam-test3" = {
      notes                          = "Test app reg3"
      service_management_reference   = "IDAM-4098"
      display_name                   = "MOJO-EUCS-IDAM-Test3"
      department_name                = "Justice-Digital"
      team_name                      = "EUCS-IDAM"
      application_name               = "MOJO-EUCS-IDAM-Test3"
      create_access_package          = false
      access_package_reviewers       = []
      owners                         = ["jgillett-admin@devl.justice.gov.uk"]      
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
