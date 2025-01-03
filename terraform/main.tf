module "application-registration" {
  source = "./modules/application-registration"

  for_each = { for s, v in local.app_registration_list : s => v if contains(v.tenants_required, terraform.workspace) }

  department_name                 = each.value.department_name
  team_name                       = each.value.team_name
  application_name                = each.value.application_name
  create_access_package           = each.value.create_access_package
  service_management_reference    = each.value.service_management_reference
  notes                           = each.value.notes
  owners                          = terraform.workspace == "LIVE" ? each.value.owners_live : terraform.workspace == "NLE" ? each.value.owners_nle : each.value.owners_devl
  homepage_url                    = each.value.homepage_url
  logout_url                      = each.value.logout_url
  redirect_uris                   = each.value.redirect_uris
  app_roles                       = each.value.app_roles
  required_resource_access_scopes = each.value.required_resource_access_scopes
  required_resource_access_roles  = each.value.required_resource_access_roles
  allowed_groups                  = each.value.allowed_groups
  access_package_reviewers        = each.value.access_package_reviewers
  federated_identity_credentials  = each.value.federated_identity_credentials
}

module "admin-access-packages" {
  source = "./modules/admin-access-packages"

  for_each = { for s, v in local.admin_access_packages : s => v if contains(v.tenants_required, terraform.workspace) }

  department_name = each.value.department_name
  team_name       = each.value.team_name
  role_name       = each.value.role_name
  roles           = each.value.roles
  catalogue_id    = azuread_access_package_catalog.admin_access_package_catalog.id
}
