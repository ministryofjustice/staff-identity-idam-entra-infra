locals {
  tags = {
    department = "HMCTS"
    team       = "Private Family Law"
    source     = "terraform"
  }
}

module "application-registration" {
  source                         = "../../../modules/application-registrationV1.8.2"
  for_each                       = local.applications
  notes                          = each.value.notes
  service_management_reference   = each.value.service_management_reference
  logo_image                     = each.value.logo_image
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
  access_token_issuance_enabled  = each.value.access_token_issuance_enabled
  id_token_issuance_enabled      = each.value.id_token_issuance_enabled
  app_roles                      = each.value.app_roles
  graph_application_permissions  = each.value.graph_application_permissions
  graph_delegated_permissions    = each.value.graph_delegated_permissions
  federated_identity_credentials = each.value.federated_identity_credentials
  service_principle              = each.value.service_principle
  identifier_uris                = each.value.identifier_uris
  api                            = each.value.api
  tags                           = each.value.tags
  resource_access                = each.value.custom_application_permissions
  spa_redirect_uris              = each.value.spa_redirect_uris
}
