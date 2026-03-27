variable "location" {
  description = "Azure region for resources to be deployed to."
  type        = string
  default     = "uksouth"
}

locals {
  applications = {
    "STG-HMCTS-PFL-Analytics-Devl" = {
      notes                          = "PFL Analytics dashboard - internal staff tool hosted on Cloud Platform (dev)"
      service_management_reference   = "DAS-1845"
      logo_image                     = "./assets/MOJ_Lesser_Arms_Stacked_HEX_215x215.jpg"
      display_name                   = "STG-HMCTS-PFL-Analytics-Devl"
      department_name                = "HMCTS"
      team_name                      = "PFL"
      application_contacts           = []
      owners                         = ["central-digital-product-team@justice.gov.uk"]
      allowed_groups                 = []
      homepage_url                   = null
      logout_url                     = null
      redirect_uris                  = ["https://pfl-analytics-dev.apps.live.cloud-platform.service.justice.gov.uk/oauth2/callback"]
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
        app_role_assignment_required  = false
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
