locals {
  tags = {
    department = "eucs"
    team       = "idam"
    source     = "terraform"
  }
}

# resource "azuread_group" "tf_test" {
#   display_name     = "APPREG-User-Access-App-Reg-Test-1"
#   security_enabled = true
# }

#region Application Registrations
module "application-registration" {
  source                         = "../../../modules/application-registrationV1.6.0"
  for_each                       = var.applications
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

