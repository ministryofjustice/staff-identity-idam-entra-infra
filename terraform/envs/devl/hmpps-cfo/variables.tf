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
    create_access_package         = bool
    access_package_reviewers      = list(string)
    owners                        = list(string)
    application_contacts          = list(string)
    allowed_groups                = list(string)
    homepage_url                  = string
    logout_url                    = string
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
    "cfo-dms-api" = {
      notes                          = "HMPPS CFO DMS API (DEVL)"
      service_management_reference   = ""
      logo_image                     = "./assets/cfo-square-icon-215x215.png"
      display_name                   = "HMPPS CFO DMS API (DEVL)"
      department_name                = "hmpps"
      team_name                      = "cfo"
      application_name               = "HMPPS CFO DMS API (DEVL)"
      create_access_package          = false
      access_package_reviewers       = []
      owners                         = ["ryan.kearsley@justice.gov.uk", "andrew.grocott@justice.gov.uk", "sam.gibson@justice.gov.uk"]
      application_contacts           = ["ryan.kearsley@justice.gov.uk", "andrew.grocott@justice.gov.uk", "sam.gibson@justice.gov.uk"]
      allowed_groups                 = []
      homepage_url                   = null
      logout_url                     = null
      redirect_uris                  = null
      mobile_desktop_redirect_uris   = null
      app_roles                      = []
      graph_application_permissions  = []
      graph_delegated_permissions    = ["User.Read"]
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
        known_client_applications      = [module.application-registration["cfo-dms-visualiser"].client_id],
        mapped_claims_enabled          = false,
        requested_access_token_version = null,
        oauth2_permission_scope = [
          {
            admin_consent_description  = "Allow the application to write data to DMS."
            admin_consent_display_name = "Write data to DMS"
            enabled                    = true
            id                         = "8B18E023-262F-494E-BD64-48E7C254B470"
            type                       = "User"
            user_consent_description   = "Allow you to write data to DMS."
            user_consent_display_name  = "Write data to DMS"
            value                      = "dms.write"
          },
          {
            admin_consent_description  = "Allow the application to read data from DMS."
            admin_consent_display_name = "Read data from DMS"
            enabled                    = true
            id                         = "2DC71A4A-A552-40B6-B5C1-9F59BC099AC9"
            type                       = "User"
            user_consent_description   = "Allow you to read data from DMS."
            user_consent_display_name  = "Read data from DMS"
            value                      = "dms.read"
          }
        ]
      }
    }
    "cfo-dms-visualiser" = {
      notes                        = "HMPPS CFO DMS Visualisation Tool (DEVL)"
      service_management_reference = ""
      logo_image                   = "./assets/cfo-square-icon-215x215.png"
      display_name                 = "HMPPS CFO DMS Visualisation Tool (DEVL)"
      department_name              = "hmpps"
      team_name                    = "cfo"
      application_name             = "HMPPS CFO DMS Visualisation Tool (DEVL)"
      create_access_package        = false
      access_package_reviewers     = []
      owners                       = ["ryan.kearsley@justice.gov.uk", "andrew.grocott@justice.gov.uk", "sam.gibson@justice.gov.uk"]
      application_contacts         = ["ryan.kearsley@justice.gov.uk", "andrew.grocott@justice.gov.uk", "sam.gibson@justice.gov.uk"]
      allowed_groups               = ["CFO Digital"]
      homepage_url                 = null
      logout_url                   = null
      redirect_uris                = ["https://dev-visualiser.co-financing.org/signin-oidc", "https://dev-visualiser.manage-external-funded-offender-provision.service.justice.gov.uk/signin-oidc"]
      mobile_desktop_redirect_uris = null
      app_roles                    = []
      graph_application_permissions = []
      graph_delegated_permissions    = ["email", "offline_access", "openid", "profile",]
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
