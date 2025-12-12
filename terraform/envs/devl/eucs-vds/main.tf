locals {

  nerdio_api_app_id = "0a052bb0-f1d1-4887-a3d0-1ac7c4477601"
  app_role_ids_by_value = data.azuread_service_principal.nerdio_api.app_role_ids
  scope_ids_by_value    = data.azuread_service_principal.nerdio_api.oauth2_permission_scope_ids
  tags = {
    department = "EUCS VDS"
    team       = "Virtual Desktop Services"
    source     = "terraform"
  }
}



locals {

}


#region Application Registrations
module "application-registration" {
  source                         = "../../../modules/application-registrationV1.1.0"
  for_each                       = var.applications
  notes                          = each.value.notes
  service_management_reference   = each.value.service_management_reference
  display_name                   = each.value.display_name
  department_name                = each.value.department_name
  team_name                      = each.value.team_name
  application_name               = each.value.application_name
  create_access_package          = each.value.create_access_package
  access_package_reviewers       = each.value.access_package_reviewers
  owners                         = each.value.owners
  allowed_groups                 = each.value.allowed_groups
  homepage_url                   = each.value.homepage_url
  logout_url                     = each.value.logout_url
  redirect_uris                  = each.value.redirect_uris
  app_roles                      = each.value.app_roles
  graph_application_permissions  = each.value.graph_application_permissions
  graph_delegated_permissions    = each.value.graph_delegated_permissions
  tenants_required               = each.value.tenants_required
  federated_identity_credentials = each.value.federated_identity_credentials
  service_principle              = each.value.service_principle
  identifier_uris                = each.value.identifier_uris
}

module "application-registration-Nerdio-api" {
  source                         = "../../../modules/application-registrationV1.5.0"
  for_each                       = var.application-nerdio-api
  notes                          = each.value.notes
  service_management_reference   = each.value.service_management_reference
  display_name                   = each.value.display_name
  department_name                = each.value.department_name
  team_name                      = each.value.team_name
  application_name               = each.value.application_name
  application_contacts           = each.value.application_contacts
  create_access_package          = each.value.create_access_package
  access_package_reviewers       = each.value.access_package_reviewers
  owners                         = each.value.owners
  allowed_groups                 = each.value.allowed_groups
  homepage_url                   = each.value.homepage_url
  logout_url                     = each.value.logout_url
  redirect_uris                  = each.value.redirect_uris
  app_roles                      = each.value.app_roles
  graph_application_permissions  = each.value.graph_application_permissions
  graph_delegated_permissions    = each.value.graph_delegated_permissions
  tenants_required               = each.value.tenants_required
  federated_identity_credentials = each.value.federated_identity_credentials
  service_principle              = each.value.service_principle
  identifier_uris                = each.value.identifier_uris
  mobile_desktop_redirect_uris   = each.value.mobile_desktop_redirect_uris
  access_token_issuance_enabled  = each.value.access_token_issuance_enabled
  id_token_issuance_enabled      = each.value.id_token_issuance_enabled
  logo_image                     = each.value.logo_image
  api_app_id                     = local.nerdio_api_app_id
  api_application_permissions    = each.value.api_application_permissions
  api_delegated_permissions      = each.value.api_delegated_permissions
  app_role_ids_by_value          = local.app_role_ids_by_value
  scope_ids_by_value             = local.scope_ids_by_value

}
#endregion
