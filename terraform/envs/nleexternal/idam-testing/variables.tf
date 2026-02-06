variable "location" {
  description = "Azure region for resources to be deployed to."
  type        = string
  default     = "uksouth"
}

variable "applications" {
  description = "Map of application details"
  type = map(object({
    notes                         = string
    service_management_reference  = string
    logo_image                    = string
    display_name                  = string
    department_name               = string
    team_name                     = string
    application_name              = string
    owners                        = list(string)
    application_contacts          = list(string)
    allowed_groups                = list(string)
    homepage_url                  = string
    logout_url                    = string
    redirect_uris                 = list(string)
    access_token_issuance_enabled = bool
    id_token_issuance_enabled     = bool
    mobile_desktop_redirect_uris  = list(string)
    tags = list(string)
    app_roles = list(object({
      allowed_member_types  = list(string)
      description           = string
      display_name          = string
      id                    = string
      value                 = string
    }))
    graph_application_permissions = list(string)
    graph_delegated_permissions   = list(string)
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
    "app1" = {
      notes                          = "EUCS IDAM App Reg Test 1 terraform"
      service_management_reference   = "IDAM-2974"
      logo_image                     = "./assets/moj-square-icon-215x215.png"
      display_name                   = "EUCS IDAM App Reg Test 1 terraform"
      department_name                = "eucs"
      team_name                      = "idam"
      application_name               = "app-reg-tf"
      owners                         = ["John.nolan_JusticeUK.onmicrosoft.com#EXT#@TestJusticeUKExternal.onmicrosoft.com", "John.Nolan@TestJusticeUKExternal.onmicrosoft.com"]
      application_contacts = [
        "idam@justice.gov.uk"
      ]
      allowed_groups                 = ["PIM-MoJO-M365-IDAM-3LS"]
      homepage_url                   = null
      logout_url                     = null
      redirect_uris                  = null
      mobile_desktop_redirect_uris   = null
      app_roles                      = []
      graph_application_permissions  = []
      graph_delegated_permissions    = ["User.Read"]
      access_token_issuance_enabled  = false
      id_token_issuance_enabled      = false
      federated_identity_credentials = []
      tags = ["Business unit: IDAM"]
      service_principle = {
        login_url                     = null
        notification_email_addresses  = []
        preferred_single_sign_on_mode = null
        app_role_assignment_required  = true
        account_enabled               = true
        application_template_name     = null
        hide                          = null
        custom_single_sign_on         = null
      }
      identifier_uris = null
      api = {
        known_client_applications      = null,
        mapped_claims_enabled          = true,
        requested_access_token_version = 2,
        oauth2_permission_scope        = []
      }
    }
  }
}
