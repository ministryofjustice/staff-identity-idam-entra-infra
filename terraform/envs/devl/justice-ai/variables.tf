variable "location" {
  description = "Azure region for resources to be deployed to."
  type        = string
  default     = "uksouth"
}

locals {
  applications = {
    "STG-AI-Justice-Transcribe-Devl" = {
      notes                          = "Justice AI Transcribe Devl App"
      service_management_reference   = "IDAM-5036"
      logo_image                     = "./assets/MOJ_Lesser_Arms_Stacked_HEX_215x215.jpg"
      display_name                   = "STG-AI-Justice-Transcribe-Devl"
      department_name                = "Justice-Digital"
      team_name                      = "AI"
      application_contacts           = ["Sam.Lhuillier@justice.gov.uk", "Harry.Waterman@justice.gov.uk", "Ehsan.Ashouri@justice.gov.uk"]
      owners                         = ["Sam.Lhuillier@justice.gov.uk", "Harry.Waterman@justice.gov.uk", "Ehsan.Ashouri@justice.gov.uk"]
      allowed_groups                 = ["JusticeTranscribeTeam"]
      homepage_url                   = null
      logout_url                     = null
      redirect_uris                  = ["https://justicetranscribe-devl-frontend.azurewebsites.net/.auth/login/aad/callback"]
      mobile_desktop_redirect_uris   = []
      access_token_issuance_enabled  = false
      id_token_issuance_enabled      = true
      app_roles                      = []
      graph_application_permissions  = []
      graph_delegated_permissions    = ["email", "openid", "profile", "User.Read", "offline_access"]
      federated_identity_credentials = []
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
      identifier_uris                = null
      api = {
        known_client_applications      = []
        mapped_claims_enabled          = false
        requested_access_token_version = null
        oauth2_permission_scope        = []
      }
      tags                           = []
      custom_application_permissions = []
      spa_redirect_uris              = []
    },
  }
}
