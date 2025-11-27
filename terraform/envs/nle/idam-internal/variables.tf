variable "location" {
  description = "Azure region for resources to be deployed to."
  type        = string
  default     = "uksouth"
}

variable "engineer_object_ids" {
  type = map(string)
  default = {
    "jason"   = "369d87ee-ed68-4cf3-8306-a711dd296d5f"
    "luciano" = "0beaf9d2-60d5-44f2-8f20-78ef6cd0341b"
    "mike"    = "d17c5b94-d6b9-4425-bdaa-08a86c9bb9da"
    "abarna"  = "16da44e7-3e25-4cf5-8d6f-2eab69859963"
    "matt"    = "a4c5e28a-4c3b-4600-b827-33ffec9a9121"
    "davidH"  = "ce142434-27d0-4112-89f5-4e768879abde"
    "davidS"  = "1ae3de89-d85f-4fb1-b1d9-36d9c641bf7d"
    "lee"     = "012ccc81-bbfa-4e94-8058-c30e6cfc5643"
    "john"    = "38cc9777-479f-450f-acf8-f8856ba861ba"
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
    "NIAM-B2C-Federation-NLE" = {
      notes                          = "NIAM-B2C-Federation-NLE"
      service_management_reference   = "IDAM-4973"
      logo_image                     = "assets/moj-square-icon-215x215.png"
      display_name                   = "NIAM-B2C-Federation-NLE"
      department_name                = "eucs"
      team_name                      = "snow"
      application_name               = "NIAM-B2C-Federation-NLE"
      create_access_package          = false
      access_package_reviewers       = []
      owners                         = ["Lee.Fairfield@TestJusticeUK.onmicrosoft.com"]      
      application_contacts           = ["Lee.Fairfield@TestJusticeUK.onmicrosoft.com"]      
      allowed_groups                 = []
      homepage_url                   = null
      logout_url                     = null
      redirect_uris                  = ["https://niamppd.b2clogin.com/niamppd.onmicrosoft.com/oauth2/authresp"]
      mobile_desktop_redirect_uris   = null
      app_roles                      = []
      graph_application_permissions  = []
      graph_delegated_permissions    = ["User.Read"]
      tenants_required               = ["NLE"]
      access_token_issuance_enabled  = false
      id_token_issuance_enabled      = false
      federated_identity_credentials = []
      service_principle = {
        login_url                     = null
        notification_email_addresses  = []
        preferred_single_sign_on_mode = null
        app_role_assignment_required  = false
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