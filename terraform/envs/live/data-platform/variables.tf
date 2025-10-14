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
    "data_platform_access" = {
      notes                          = "Data Platform Access (https://github.com/ministryofjustice/data-platform-access)"
      service_management_reference   = ""
      logo_image                     = "./assets/moj-square-icon-215x215.png"
      display_name                   = "Data Platform Access"
      department_name                = "office-of-the-cto"
      team_name                      = "data-platform"
      application_name               = "access"
      create_access_package          = false
      access_package_reviewers       = []
      owners                         = ["DataPlatform-gg@justice.gov.uk","Jacob.Woffenden@justice.gov.uk"]      
      application_contacts           = ["Jacob.Woffenden@justice.gov.uk"]      
      allowed_groups                 = []
      homepage_url                   = null
      logout_url                     = null
      redirect_uris                  = null
      mobile_desktop_redirect_uris   = null
      app_roles                      = []
      # Based on https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group#api-permissions
      graph_application_permissions  = [
        "Group.ReadWrite.All",
        "Directory.ReadWrite.All",
        "User.ReadWrite.All",
      ]
      graph_delegated_permissions    = []
      tenants_required               = ["LIVE"]
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
        oauth2_permission_scope = []
      }
    }
  }
}
