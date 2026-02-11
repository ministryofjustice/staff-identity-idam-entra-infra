locals {
  tags = {
    department = "eucs"
    team       = "idam"
    source     = "terraform"
  }
}

resource "random_uuid" "scope_obo_internal_api" {} # Scope exposed by Internal API
resource "random_uuid" "scope_obo_shared_api" {}  # Scope exposed by Shared Docs API
resource "random_uuid" "approle_files_write_s2s_example_api_resource" {}  # uuid for s2s API resource role
resource "random_uuid" "scope_auth_code_flow_example_api" {} # Scope exposed by Internal API

# resource "azuread_group" "tf_test" {
#   display_name     = "APPREG-User-Access-App-Reg-Test-1"
#   security_enabled = true
# }

#region Application Registrations
module "application-registration" {
  source                         = "../../../modules/application-registrationV1.6.0"
  for_each                       = local.applications
  notes                          = each.value.notes
  logo_image                     = each.value.logo_image
  service_management_reference   = each.value.service_management_reference
  display_name                   = each.value.display_name
  department_name                = each.value.department_name
  team_name                      = each.value.team_name
  application_name               = each.value.application_name
  owners                         = each.value.owners
  allowed_groups                 = each.value.allowed_groups
  homepage_url                   = each.value.homepage_url
  logout_url                     = each.value.logout_url
  redirect_uris                  = each.value.redirect_uris
  mobile_desktop_redirect_uris   = each.value.mobile_desktop_redirect_uris
  app_roles                      = each.value.app_roles
  resource_access                = each.value.resource_access
  graph_application_permissions  = each.value.graph_application_permissions
  graph_delegated_permissions    = each.value.graph_delegated_permissions
  federated_identity_credentials = each.value.federated_identity_credentials
  service_principle              = each.value.service_principle
  identifier_uris                = each.value.identifier_uris
  application_contacts           = each.value.application_contacts
  api                            = each.value.api
  access_token_issuance_enabled  = each.value.access_token_issuance_enabled
  id_token_issuance_enabled      = each.value.id_token_issuance_enabled
  tags                           = each.value.tags
}
#endregion

locals {
  applications = {
    "app1" = {
      notes                        = "EUCS IDAM App Reg Test 1 terraform"
      service_management_reference = "IDAM-2974"
      logo_image                   = "./assets/moj-square-icon-215x215.png"
      display_name                 = "EUCS IDAM App Reg Test 1 terraform"
      department_name              = "eucs"
      team_name                    = "idam"
      application_name             = "app-reg-tf"
      owners                       = ["John.nolan_JusticeUK.onmicrosoft.com#EXT#@TestJusticeUKExternal.onmicrosoft.com", "John.Nolan@TestJusticeUKExternal.onmicrosoft.com"]
      application_contacts = [
        "idam@justice.gov.uk"
      ]
      allowed_groups                 = ["PIM-MoJO-M365-IDAM-3LS"]
      homepage_url                   = null
      logout_url                     = null
      redirect_uris                  = null
      mobile_desktop_redirect_uris   = null
      app_roles                      = []
      resource_access                = []
      graph_application_permissions  = []
      graph_delegated_permissions    = ["User.Read"]
      access_token_issuance_enabled  = false
      id_token_issuance_enabled      = false
      federated_identity_credentials = []
      tags                           = ["Business unit: IDAM", "authPattern: SSO"]
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
    "obo_example_shared_api" = {
      notes                        = "OBO Example Shared API"
      service_management_reference = "IDAM-5755"
      logo_image                   = "./assets/moj-square-icon-215x215.png"
      display_name                 = "OBO Example Shared API"
      department_name              = "eucs"
      team_name                    = "idam"
      application_name             = "obo-example-shared-api"
      owners                       = ["John.nolan_JusticeUK.onmicrosoft.com#EXT#@TestJusticeUKExternal.onmicrosoft.com", "John.Nolan@TestJusticeUKExternal.onmicrosoft.com"]
      application_contacts = [
        "idam@justice.gov.uk"
      ]
      allowed_groups               = []
      homepage_url                 = "https://test.justice.gov.uk"
      logout_url                   = null
      redirect_uris                = ["https://shared.internal.justice.gov.uk/auth"]
      mobile_desktop_redirect_uris = null
      app_roles                    = []
      resource_access              = []
      graph_application_permissions  = []
      graph_delegated_permissions    = ["User.Read"]
      access_token_issuance_enabled  = false
      id_token_issuance_enabled      = false
      federated_identity_credentials = []
      tags                           = ["Business unit: IDAM", "authPattern: OBO"]
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
      identifier_uris = ["api://shared-documents"]
      api = {
        known_client_applications      = null,
        mapped_claims_enabled          = true,
        requested_access_token_version = 2,
        oauth2_permission_scope        = [
          {
            admin_consent_description  = "Allow the app to access shared documents."
            admin_consent_display_name = "Read Shared Documents"
            user_consent_description   = null
            user_consent_display_name  = null
            enabled                    = true
            id                         = random_uuid.scope_obo_shared_api.result
            type                       = "User"
            value                      = "Documents.Read"
          }
        ]
      }
    },
    "obo_example_internal_api" = {
      notes                        = "OBO Example Internal API"
      service_management_reference = "IDAM-5755"
      logo_image                   = "./assets/moj-square-icon-215x215.png"
      display_name                 = "OBO Example Internal API"
      department_name              = "eucs"
      team_name                    = "idam"
      application_name             = "obo-example-internal-api"
      owners                       = ["John.nolan_JusticeUK.onmicrosoft.com#EXT#@TestJusticeUKExternal.onmicrosoft.com", "John.Nolan@TestJusticeUKExternal.onmicrosoft.com"]
      application_contacts = [
        "idam@justice.gov.uk"
      ]
      allowed_groups                 = []
      homepage_url                   = null
      logout_url                     = null
      redirect_uris                  = ["https://internal.test.justice.gov.uk/auth"]
      mobile_desktop_redirect_uris   = null
      app_roles                      = []
      resource_access                = [       
        {
          resource_app_name = "OBO Example Shared API"
          resource_access = {
            id   = random_uuid.scope_obo_shared_api.result # Requesting 'Documents.Read'
            type = "Scope"
          }
        }
      ]
      graph_application_permissions  = []
      graph_delegated_permissions    = ["User.Read"]
      access_token_issuance_enabled  = false
      id_token_issuance_enabled      = false
      federated_identity_credentials = []
      tags                           = ["Business unit: IDAM", "authPattern: OBO"]
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
      identifier_uris = ["api://obo-example-internal-api"]
      api = {
        known_client_applications      = null,
        mapped_claims_enabled          = true,
        requested_access_token_version = 2,
        oauth2_permission_scope = [
          {
            admin_consent_description  = "Allow the app to access SDS on behalf of the user."
            admin_consent_display_name = "Access SDS"
            user_consent_description   = null
            user_consent_display_name  = null
            enabled                    = true
            id                         = random_uuid.scope_obo_internal_api.result
            type                       = "User"
            value                      = "user_impersonation"
          }
        ]
      }
    },
    "obo_example_frontend" = {
      notes                        = "OBO Example Case Management Web App (Frontend)"
      service_management_reference = "IDAM-5755"
      logo_image                   = "./assets/moj-square-icon-215x215.png"
      display_name                 = "OBO Example Case Management Web App (Frontend)"
      department_name              = "eucs"
      team_name                    = "idam"
      application_name             = "obo-example-frontend"
      owners                       = ["John.nolan_JusticeUK.onmicrosoft.com#EXT#@TestJusticeUKExternal.onmicrosoft.com", "John.Nolan@TestJusticeUKExternal.onmicrosoft.com"]
      application_contacts = [
        "idam@justice.gov.uk"
      ]
      allowed_groups               = []
      homepage_url                 = "https://test.justice.gov.uk"
      logout_url                   = null
      redirect_uris                = ["https://test.justice.gov.uk/auth"]
      mobile_desktop_redirect_uris = null
      app_roles                    = []
      resource_access              = [
        {
          resource_app_name = "OBO Example Internal API"
          resource_access = {
            id   = random_uuid.scope_obo_internal_api.result # Requesting 'user_impersonation'
            type = "Scope"
          }
        }
      ]
      graph_application_permissions  = []
      graph_delegated_permissions    = ["User.Read"]
      access_token_issuance_enabled  = false
      id_token_issuance_enabled      = false
      federated_identity_credentials = []
      tags                           = ["Business unit: IDAM", "authPattern: OBO"]
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
    },
    "s2s_example_api_resource" = {
      notes                        = "S2S Example API Resource"
      service_management_reference = "IDAM-5755"
      logo_image                   = "./assets/moj-square-icon-215x215.png"
      display_name                 = "S2S Example API Resource"
      department_name              = "eucs"
      team_name                    = "idam"
      application_name             = "s2s-example-api-resource"
      owners                       = ["John.nolan_JusticeUK.onmicrosoft.com#EXT#@TestJusticeUKExternal.onmicrosoft.com", "John.Nolan@TestJusticeUKExternal.onmicrosoft.com"]
      application_contacts = [
        "idam@justice.gov.uk"
      ]
      allowed_groups                 = []
      homepage_url                   = null
      logout_url                     = null
      redirect_uris                  = ["https://internal.test.justice.gov.uk/auth"]
      mobile_desktop_redirect_uris   = null
      app_roles                      = [
        {
          id                   = random_uuid.approle_files_write_s2s_example_api_resource.result
          allowed_member_types = ["Application"]
          description          = "Allows background services to upload files."
          display_name         = "Files.Write"
          enabled              = true
          value                = "Files.Write"
        }
      ]
      resource_access                = []
      graph_application_permissions  = []
      graph_delegated_permissions    = ["User.Read"]
      access_token_issuance_enabled  = false
      id_token_issuance_enabled      = false
      federated_identity_credentials = []
      tags                           = ["Business unit: IDAM", "authPattern: S2S"]
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
      identifier_uris = ["api://s2s-example-api-resource"]
      api = {
        known_client_applications      = null,
        mapped_claims_enabled          = true,
        requested_access_token_version = 2,
        oauth2_permission_scope = []
      }
    },
    "s2s_example_consumer" = {
      notes                        = "S2S Example Consumer"
      service_management_reference = "IDAM-5755"
      logo_image                   = "./assets/moj-square-icon-215x215.png"
      display_name                 = "S2S Example Consumer"
      department_name              = "eucs"
      team_name                    = "idam"
      application_name             = "s2s-example-consumer"
      owners                       = ["John.nolan_JusticeUK.onmicrosoft.com#EXT#@TestJusticeUKExternal.onmicrosoft.com", "John.Nolan@TestJusticeUKExternal.onmicrosoft.com"]
      application_contacts = [
        "idam@justice.gov.uk"
      ]
      allowed_groups               = []
      homepage_url                 = "https://test.consumer.justice.gov.uk"
      logout_url                   = null
      redirect_uris                = ["https://test.justice.gov.uk/auth"]
      mobile_desktop_redirect_uris = null
      app_roles                    = []
      resource_access              = [
        {
          resource_app_name = "S2S Example API Resource"
          resource_access = {
            id   = random_uuid.approle_files_write_s2s_example_api_resource.result
            type = "Scope"
          }
        }
      ]
      graph_application_permissions  = []
      graph_delegated_permissions    = ["User.Read"]
      access_token_issuance_enabled  = false
      id_token_issuance_enabled      = false
      federated_identity_credentials = []
      tags                           = ["Business unit: IDAM", "authPattern: S2S"]
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
    },
    "auth_code_flow_example_webapp" = {
      notes                        = "Auth Code Flow Example Web App"
      service_management_reference = "IDAM-5755"
      logo_image                   = "./assets/moj-square-icon-215x215.png"
      display_name                 = "Auth Code Flow Example Web App"
      department_name              = "eucs"
      team_name                    = "idam"
      application_name             = "auth-code-flow-example-webapp"
      owners                       = ["John.nolan_JusticeUK.onmicrosoft.com#EXT#@TestJusticeUKExternal.onmicrosoft.com", "John.Nolan@TestJusticeUKExternal.onmicrosoft.com"]
      application_contacts = [
        "idam@justice.gov.uk"
      ]
      allowed_groups               = []
      homepage_url                 = "https://test.webapp.justice.gov.uk"
      logout_url                   = null
      redirect_uris                = ["https://test.webapp.justice.gov.uk/auth"]
      mobile_desktop_redirect_uris = null
      app_roles                    = []
      resource_access              = []
      graph_application_permissions  = []
      graph_delegated_permissions    = ["User.Read"]
      access_token_issuance_enabled  = false
      id_token_issuance_enabled      = false
      federated_identity_credentials = []
      tags                           = ["Business unit: IDAM", "authPattern: AuthCodeFlow"]
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
      identifier_uris = ["api://auth-code-flow-example-webapp"]
      api = {
        known_client_applications      = null,
        mapped_claims_enabled          = true, # This API needs to have 'mapped_claims_enabled' set to true in order for the 'scp' claim to be included in access tokens when using the v2.0 endpoint.
        requested_access_token_version = 2, # This API expects v2.0 tokens with the 'scp' claim for scopes, not v1.0 tokens with the 'roles' claim
        oauth2_permission_scope        = [
          {
            admin_consent_description  = "Allow the app to access shared documents."
            admin_consent_display_name = "Read Shared Documents"
            user_consent_description   = null
            user_consent_display_name  = null
            enabled                    = true
            id                         = random_uuid.scope_auth_code_flow_example_api.result
            type                       = "User"
            value                      = "Documents.Read"
          }
        ]
      }
    },
    "auth_code_flow_example_api" = {
      notes                        = "Auth Code Flow Example API"
      service_management_reference = "IDAM-5755"
      logo_image                   = "./assets/moj-square-icon-215x215.png"
      display_name                 = "Auth Code Flow Example API"
      department_name              = "eucs"
      team_name                    = "idam"
      application_name             = "auth-code-flow-example-api"
      owners                       = ["John.nolan_JusticeUK.onmicrosoft.com#EXT#@TestJusticeUKExternal.onmicrosoft.com", "John.Nolan@TestJusticeUKExternal.onmicrosoft.com"]
      application_contacts = [
        "idam@justice.gov.uk"
      ]
      allowed_groups               = []
      homepage_url                 = "https://test.api.justice.gov.uk"
      logout_url                   = null
      redirect_uris                = ["https://test.api.justice.gov.uk/auth"]
      mobile_desktop_redirect_uris = null
      app_roles                    = []
      resource_access                = [       
        {
          resource_app_name = "Auth Code Flow Example Web App"
          resource_access = {
            id   = random_uuid.scope_auth_code_flow_example_api.result # Requesting 'Documents.Read'
            type = "Scope"
          }
        }
      ]
      graph_application_permissions  = []
      graph_delegated_permissions    = ["User.Read"]
      access_token_issuance_enabled  = false
      id_token_issuance_enabled      = false
      federated_identity_credentials = []
      tags                           = ["Business unit: IDAM", "authPattern: AuthCodeFlow"]
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
      identifier_uris = ["api://auth-code-flow-example-api"]
      api = {
        known_client_applications      = null,
        mapped_claims_enabled          = true, # This API needs to have 'mapped_claims_enabled' set to true in order for the 'scp' claim to be included in access tokens when using the v2.0 endpoint.
        requested_access_token_version = 2, # This API expects v2.0 tokens with the 'scp' claim for scopes, not v1.0 tokens with the 'roles' claim
        oauth2_permission_scope        = []
      }
    },
  }
}
      