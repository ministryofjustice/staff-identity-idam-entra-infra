module "application-registration" {
  source = "./modules/application-registration"

  for_each = local.app_registration_list

  display_name                    = each.value.display_name
  department_name                 = each.value.department_name
  team_name                       = each.value.team_name
  application_name                = each.value.application_name
  create_access_package           = each.value.create_access_package
  service_management_reference    = each.value.service_management_reference
  notes                           = each.value.notes
  owners                          = each.value.owners
  homepage_url                    = each.value.homepage_url
  logout_url                      = each.value.logout_url
  redirect_uris                   = each.value.redirect_uris
  app_roles                       = each.value.app_roles
  required_resource_access_scopes = each.value.required_resource_access_scopes
  required_resource_access_roles  = each.value.required_resource_access_roles
}
