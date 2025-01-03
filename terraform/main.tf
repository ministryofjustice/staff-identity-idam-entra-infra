module "application-registration" {
  source = "./modules/application-registration"

  for_each = { for s, v in local.app_registration_list : s => v if contains(v.tenants_required, terraform.workspace) }

  display_name                   = each.value.display_name
  department_name                = each.value.department_name
  team_name                      = each.value.team_name
  application_name               = each.value.application_name
  create_access_package          = each.value.create_access_package
  service_management_reference   = each.value.service_management_reference
  notes                          = each.value.notes
  owners                         = terraform.workspace == "LIVE" ? each.value.owners_live : terraform.workspace == "NLE" ? each.value.owners_nle : each.value.owners_devl
  homepage_url                   = each.value.homepage_url
  logout_url                     = each.value.logout_url
  redirect_uris                  = each.value.redirect_uris
  app_roles                      = each.value.app_roles
  graph_delegated_permissions    = each.value.graph_delegated_permissions
  graph_application_permissions  = each.value.graph_application_permissions
  allowed_groups                 = each.value.allowed_groups
  access_package_reviewers       = each.value.access_package_reviewers
  federated_identity_credentials = each.value.federated_identity_credentials
  application_template_name      = each.value.application_template_name
}
