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
    logo_image                    = string
    display_name                 = string
    department_name              = string
    team_name                    = string
    application_name             = string
    create_access_package        = bool
    access_package_reviewers     = list(string)
    owners                       = list(string)
    application_contacts          = list(string)
    allowed_groups               = list(string)
    homepage_url                 = string
    logout_url                   = string
    redirect_uris                 = list(string)
    access_token_issuance_enabled = bool
    id_token_issuance_enabled     = bool
    mobile_desktop_redirect_uris  = list(string)
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
      custom_single_sign_on         = bool
    })
    identifier_uris = list(string)
    api = object({
      known_client_applications      = list(string)
      mapped_claims_enabled          = bool
      requested_access_token_version = string
      oauth2_permission_scope = list(object({
        admin_consent_description  = string
        admin_consent_display_name = string
        enabled                    = bool
        id                         = string
        type                       = string
        user_consent_description   = string
        user_consent_display_name  = string
        value                      = string
      }))
    })
  }))
  default = {
    "apim-alztest" = {
      notes                          = "APIM API app registration for AI Enablement (dev)"
      service_management_reference   = "TBD"
      logo_image                     = "./assets/moj-square-icon-215x215.png"
      display_name                   = "apim-alztest"
      department_name                = "Justice-Digital"
      team_name                      = "Azure-Landing-Zone"
      application_name               = "apim-alztest"
      create_access_package          = false
      access_package_reviewers       = []
      owners                         = ["ALZ3S@justice.gov.uk"]
      application_contacts           = ["ALZ3S@justice.gov.uk"]
      allowed_groups                 = []
      homepage_url                   = null
      logout_url                     = null
      redirect_uris                  = []
      mobile_desktop_redirect_uris   = null
      app_roles = [
        {
          allowed_member_types  = ["Application"]
          description           = "Allow service principals to access APIM"
          display_name          = "APIM.Access"
          id                    = "1e13984b-059e-4227-be82-aba328b50a44"
          value                 = "APIM.Access"
          access_package_hidden = true
        }
      ]
      graph_application_permissions  = []
      graph_delegated_permissions    = []
      tenants_required               = ["DEVL"]
      access_token_issuance_enabled  = false
      id_token_issuance_enabled      = false
      federated_identity_credentials = []
      service_principle = {
        login_url                     = null
        notification_email_addresses  = []
        preferred_single_sign_on_mode = null
        app_role_assignment_required  = true
        account_enabled               = true
        application_template_name     = null
        hide                          = true
        custom_single_sign_on         = null
      }
      # Uses tenant-id based identifier URI to meet policy requirements
      identifier_uris = ["api://0bb413d7-160d-4839-868a-f3d46537f6af/apim-alztest"]
      api = {
        known_client_applications      = [],
        mapped_claims_enabled          = false,
        requested_access_token_version = null,
        oauth2_permission_scope        = []
      }
    }
    "moj-devl-apim-access-client" = {
      notes                          = "Client app registration for APIM access (dev)"
      service_management_reference   = "TBD"
      logo_image                     = "./assets/moj-square-icon-215x215.png"
      display_name                   = "moj-devl-apim-access-client"
      department_name                = "Justice-Digital"
      team_name                      = "Azure-Landing-Zone"
      application_name               = "moj-devl-apim-access-client"
      create_access_package          = false
      access_package_reviewers       = []
      owners                         = ["ALZ3S@justice.gov.uk"]
      application_contacts           = ["ALZ3S@justice.gov.uk"]
      allowed_groups                 = []
      homepage_url                   = null
      logout_url                     = null
      redirect_uris                  = []
      mobile_desktop_redirect_uris   = null
      app_roles                      = []
      graph_application_permissions  = []
      graph_delegated_permissions    = []
      tenants_required               = ["DEVL"]
      access_token_issuance_enabled  = false
      id_token_issuance_enabled      = false
      federated_identity_credentials = []
      service_principle = {
        login_url                     = null
        notification_email_addresses  = []
        preferred_single_sign_on_mode = null
        app_role_assignment_required  = true
        account_enabled               = true
        application_template_name     = null
        hide                          = true
        custom_single_sign_on         = null
      }
      identifier_uris = null
      api = {
        known_client_applications      = [],
        mapped_claims_enabled          = false,
        requested_access_token_version = null,
        oauth2_permission_scope        = []
      }
    }
  }
}
