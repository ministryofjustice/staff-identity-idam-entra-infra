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
}),
custom_application_permissions = list(object({
  resource_app_id = string
  resource_access = list(object({
    id   = string
    type = string
  }))
})),


  }))
  default = {
    "sabc-production" = {
      notes                          = "Submit a bulk claims app registration for app to app authentication only, this is not for SiLAS frontend login"
      service_management_reference   = ""
      logo_image                     = "./assets/laa-square-icon-215x215.jpg"
      display_name                   = "Submit a bulk claim | Production | app2app"
      department_name                = "laa"
      team_name                      = "sabc"
      application_name               = "submit-a-bulk-claim-production-app2app"
      create_access_package          = false
      access_package_reviewers       = []
      owners                         = ["phil.payne@justice.gov.uk", "rohan.salunkhe1@justice.gov.uk"]
      application_contacts           = ["phil.payne@justice.gov.uk","rohan.salunkhe1@justice.gov.uk"]
      allowed_groups                 = []
      homepage_url                   = null
      logout_url                     = null
      redirect_uris                  = null
      mobile_desktop_redirect_uris   = null
      app_roles                      = []
      custom_application_permissions = [
        {
          resource_app_id = "5ece4513-0ec7-4178-b0d9-ed5c044b6ad5"
          resource_access = [
            {
              id   = "6f49626e-8517-48d1-b6ce-692bd508cb9a" # LAA_SDS.ALL
              type = "Role"                                # Application permission
            }
          ]
        }
      ]
      graph_application_permissions  = []
      graph_delegated_permissions    = ["User.Read"]
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
    },
    "sabc-staging" = {
      notes                          = "Submit a bulk claims app registration for app to app authentication only, this is not for SiLAS frontend login"
      service_management_reference   = ""
      logo_image                     = "./assets/laa-square-icon-215x215.jpg"
      display_name                   = "Submit a bulk claim | Staging | app2app"
      department_name                = "laa"
      team_name                      = "sabc"
      application_name               = "submit-a-bulk-claim-staging-app2app"
      create_access_package          = false
      access_package_reviewers       = []
      owners                         = ["phil.payne@justice.gov.uk", "rohan.salunkhe1@justice.gov.uk"]
      application_contacts           = ["phil.payne@justice.gov.uk","rohan.salunkhe1@justice.gov.uk"]
      allowed_groups                 = []
      homepage_url                   = null
      logout_url                     = null
      redirect_uris                  = null
      mobile_desktop_redirect_uris   = null
      custom_application_permissions = [
  {
    resource_app_id = "fb5951f7-580c-4d0b-94ef-ede2619cb319"
    resource_access = [
      {
        id   = "70b6852e-1c0c-4aaa-91ef-f4f2edb86845" # LAA_SDS.ALL
        type = "Role"                                # Application permission
      }
    ]
  }
]
      app_roles                      = []
      graph_application_permissions  = []
      graph_delegated_permissions    = ["User.Read"]
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
    },
    "Data-Stewardship-UAT" = {
      notes                          = "Data Stewardship app registration for app to app authentication only, this is not for SiLAS frontend login"
      service_management_reference   = ""
      logo_image                     = "./assets/laa-square-icon-215x215.jpg"
      display_name                   = "DataStewardship | UAT | app2app"
      department_name                = "laa"
      team_name                      = "DataStewardship"
      application_name               = "Data-Stewardship-API-UAT-app2app"
      create_access_package          = false
      access_package_reviewers       = []
      owners                         = ["Saif-ul.Hussain@justice.gov.uk"]
      application_contacts           = ["Saif-ul.Hussain@justice.gov.uk"]
      allowed_groups                 = []
      homepage_url                   = null
      logout_url                     = null
      redirect_uris                  = null
      mobile_desktop_redirect_uris   = null
      app_roles                      = []
      custom_application_permissions = [
  {
    resource_app_id = "fb5951f7-580c-4d0b-94ef-ede2619cb319"
    resource_access = [
      {
        id   = "70b6852e-1c0c-4aaa-91ef-f4f2edb86845" # LAA_SDS.ALL
        type = "Role"                                # Application permission
      }
    ]
  }
]
      graph_application_permissions  = []
      graph_delegated_permissions    = ["User.Read"]
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
