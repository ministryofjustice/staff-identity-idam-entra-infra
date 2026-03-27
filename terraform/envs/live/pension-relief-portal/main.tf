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
  source                         = "../../../modules/application-registrationV1.8.2"
  for_each                       = local.applications
  notes                          = each.value.notes
  logo_image                     = each.value.logo_image
  service_management_reference   = each.value.service_management_reference
  display_name                   = each.value.display_name
  department_name                = each.value.department_name
  team_name                      = each.value.team_name
  owners                         = each.value.owners
  application_contacts           = each.value.application_contacts
  allowed_groups                 = each.value.allowed_groups
  homepage_url                   = each.value.homepage_url
  logout_url                     = each.value.logout_url
  redirect_uris                  = each.value.redirect_uris
  mobile_desktop_redirect_uris   = each.value.mobile_desktop_redirect_uris
  app_roles                      = each.value.app_roles
  graph_application_permissions  = each.value.graph_application_permissions
  graph_delegated_permissions    = each.value.graph_delegated_permissions
  access_token_issuance_enabled  = each.value.access_token_issuance_enabled
  id_token_issuance_enabled      = each.value.id_token_issuance_enabled
  federated_identity_credentials = each.value.federated_identity_credentials
  service_principle              = each.value.service_principle
  identifier_uris                = each.value.identifier_uris
  api                            = each.value.api
  tags                           = each.value.tags
  resource_access                = each.value.custom_application_permissions
}
#endregion

locals {
  applications = {
    "pipeline_app" = {
      notes                        = "Used to deploy Pension Relief infrastructure and code to prod resource group"
      service_management_reference = "IDAM-5926"
      logo_image                   = "assets/MOJ_Lesser_Arms_Stacked_HEX_215x215.jpg"
      display_name                 = "MoJO-PROD-rg-eucs-pensionrelief-003"
      department_name              = "EUCS"
      team_name                    = "Application-Platforms"
      owners                       = ["cameron.cowen@justiceuk.onmicrosoft.com"]
      application_contacts = [
        "Cameron Cowen",
        "John Nolan"
      ]
      allowed_groups               = []
      homepage_url                 = null
      logout_url                   = null
      redirect_uris                = null
      mobile_desktop_redirect_uris = null
      app_roles                    = []
      graph_application_permissions = [
        "Application.ReadWrite.OwnedBy",
        "Directory.Read.All",
        "Group.ReadWrite.All"
      ]
      graph_delegated_permissions    = []
      access_token_issuance_enabled  = false
      id_token_issuance_enabled      = false
      federated_identity_credentials = []
      tags = ["Business unit: EUCS", "authPattern: ProductionPipeline", "project: PensionReliefPortal"]
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
      custom_application_permissions = []
    }
  }
}
