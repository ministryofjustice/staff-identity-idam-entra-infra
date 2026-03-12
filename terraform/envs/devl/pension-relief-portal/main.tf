locals {
  tags = {
    department = "eucs"
    team       = "idam"
    source     = "terraform"
  }
}

resource "random_uuid" "application_role_id_access_read" {} # Scope exposed by Internal API

#region Application Registrations
module "application-registration" {
  source                         = "../../../modules/application-registrationV1.8.1"
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
  resource_access                = each.value.custom_application_permissions
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
    "pension_relief_portal_auth0_client" = {
      notes                        = "Used for authenticating users of the Pension Relief Portal and providing access tokens for Auth0 to call the Allowlist API."
      service_management_reference = "IDAM-5926"
      logo_image                   = "./assets/MOJ_Lesser_Arms_Stacked_HEX_215x215.jpg"
      display_name                 = "Pension Relief Portal - Auth0 Client"
      department_name              = "eucs"
      team_name                    = "idam"
      application_name             = "pension-relief-portal-auth0-client"
      owners                       = ["jnolan-admin@devl.justice.gov.uk", "ccowen-admin@devl.justice.gov.uk"]
      application_contacts = [
        "john.nolan@justice.gov.uk",
        "Cameron.Cowen@justice.gov.uk",
        "Ozair.Ishan@justice.gov.uk"
      ]
      allowed_groups               = []
      homepage_url                 = null
      logout_url                   = null
      redirect_uris                = null
      mobile_desktop_redirect_uris = null
      app_roles = []
      graph_application_permissions  = []
      graph_delegated_permissions    = []
      access_token_issuance_enabled  = false
      id_token_issuance_enabled      = false
      federated_identity_credentials = []
      tags = ["Business unit: EUCS", "authPattern: ClientCredentials"]
      service_principle = {
        login_url                     = null
        notification_email_addresses  = ["jnolan-admin@devl.justice.gov.uk"]
        preferred_single_sign_on_mode = null
        app_role_assignment_required  = false
        account_enabled               = true
        application_template_name     = null
        hide                          = true
        custom_single_sign_on         = null
      }
      identifier_uris = null
      api = {
        known_client_applications      = []
        mapped_claims_enabled          = false
        requested_access_token_version = 2
        oauth2_permission_scope = []
      }
      custom_application_permissions = [
        {
          resource_app_id = "05315584-e994-4090-ab67-7ed0a85da9d5"
          resource_access = [
            {
              id   = random_uuid.application_role_id_access_read.result
              type = "Role"
            }
          ]
        }
      ]
    },
    "pension_relief_portal_allowlist_api" = {
      notes                        = "Pension Relief Portal - Allowlist API"
      service_management_reference = "IDAM-5926"
      logo_image                   = "./assets/MOJ_Lesser_Arms_Stacked_HEX_215x215.jpg"
      display_name                 = "Pension Relief Portal - Allowlist API"
      department_name              = "eucs"
      team_name                    = "idam"
      application_name             = "pension-relief-portal-allowlist-api"
      owners                       = ["jnolan-admin@devl.justice.gov.uk", "ccowen-admin@devl.justice.gov.uk"]
      application_contacts = [
        "john.nolan@justice.gov.uk",
        "Cameron.Cowen@justice.gov.uk",
        "Ozair.Ishan@justice.gov.uk"
      ]
      allowed_groups               = []
      homepage_url                 = null
      logout_url                   = null
      redirect_uris                = null
      mobile_desktop_redirect_uris = null
      app_roles = [
        {
          allowed_member_types       = ["Application"],
          description                = "Allows access to the Pension Relief Portal Allow List API",
          display_name               = "Access.Read",
          id                         = random_uuid.application_role_id_access_read.result,
          value                      = "Access.Read"
        }
      ]
      graph_application_permissions  = []
      graph_delegated_permissions    = []
      access_token_issuance_enabled  = false
      id_token_issuance_enabled      = false
      federated_identity_credentials = []
      tags = ["Business unit: EUCS", "authPattern: ClientCredentials"]
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
      identifier_uris = ["api://05315584-e994-4090-ab67-7ed0a85da9d5"]
      api = {
        known_client_applications      = []
        mapped_claims_enabled          = false
        requested_access_token_version = 2
        oauth2_permission_scope        = []
      }
      custom_application_permissions = []
    },
  }
}
