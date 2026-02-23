locals {
  tags = {
    department = "LAA"
    team       = "Client Access to Legal Advice"
    source     = "terraform"
  }
}

resource "random_uuid" "scope_auth_code_flow_api" {} # Scope exposed by Internal API

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
    "cala-clah-nle" = {
      notes                          = "Civil Legal Advice Helpline"
      service_management_reference   = ""
      logo_image                     = "./assets/laa-square-icon-215x215.jpg"
      display_name                   = "Civil Legal Advice Helpline"
      department_name                = "LAA"
      team_name                      = "CALA"
      application_name               = "CLAH"
      owners                         = []
      application_contacts           = ["cladevs-gg@justice.gov.uk"]
      allowed_groups                 = []
      homepage_url                   = null
      logout_url                     = null
      redirect_uris                  = null
      mobile_desktop_redirect_uris   = null
      app_roles                      = []
      resource_access                = [
        {
          resource_app_name = "Cla Backend API"
          resource_access = {
            id   = "649b9baa-64bf-41fb-932c-d50d31bb2e8f" # Requesting 'Client.CLAH'
            type = "Scope"
          }
        }
      ]
      graph_application_permissions  = []
      graph_delegated_permissions    = []
      access_token_issuance_enabled  = false
      id_token_issuance_enabled      = false
      federated_identity_credentials = []
      tags                           = ["Business unit: LAA", "authPattern: Authorization Code Pattern"]
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
        requested_access_token_version = null,
        oauth2_permission_scope        = []
      }
    }
    "cala-cla-backend-nle" = {
      notes                        = "Cla Backend"
      service_management_reference = ""
      logo_image                   = "./assets/laa-square-icon-215x215.jpg"
      display_name                 = "Cla Backend"
      department_name              = "LAA"
      team_name                    = "CALA"
      application_name             = "CLA-Backend"
      owners                       = []
      application_contacts         = ["cladevs-gg@justice.gov.uk"]
      allowed_groups               = []
      homepage_url                 = null
      logout_url                   = null
      redirect_uris                = null
      mobile_desktop_redirect_uris = null
      app_roles                    = []
      resource_access              = []
      graph_application_permissions  = []
      graph_delegated_permissions    = []
      access_token_issuance_enabled  = false
      id_token_issuance_enabled      = false
      federated_identity_credentials = []
      tags                           = ["Business unit: LAA", "authPattern: Authorization Code Pattern"]
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
        requested_access_token_version = null,
        oauth2_permission_scope        = [
          {
            admin_consent_description  = "Allow access from Civil Legal Advice Helpline Client"
            admin_consent_display_name = "Civil Legal Advice Helpline Client"
            user_consent_description   = null
            user_consent_display_name  = null
            enabled                    = true
            id                         = random_uuid.scope_auth_code_flow_api.result
            type                       = "User"
            value                      = "Client.CLAH"
          }
        ]
      }
    }
  }
}
      