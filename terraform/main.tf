module "application-registration" {
  source = "./modules/application-registration"

  for_each = { for s, v in local.app_registration_list : s => v if contains(v.tenants_required, terraform.workspace) }

  display_name                  = each.value.display_name
  department_name               = each.value.department_name
  team_name                     = each.value.team_name
  application_name              = each.value.application_name
  create_access_package         = lookup(each.value, "create_access_package", false)
  service_management_reference  = each.value.service_management_reference
  notes                         = each.value.notes
  owners                        = terraform.workspace == "LIVE" ? each.value.owners_live : terraform.workspace == "NLE" ? lookup(each.value, "owners_nle", []) : lookup(each.value, "owners_devl", [])
  homepage_url                  = each.value.homepage_url
  logout_url                    = each.value.logout_url
  redirect_uris                 = each.value.redirect_uris
  app_roles                     = lookup(each.value, "app_roles", [])
  graph_delegated_permissions   = lookup(each.value, "graph_delegated_permissions", [])
  graph_application_permissions = lookup(each.value, "graph_application_permissions", [])
  allowed_groups                = lookup(each.value, "allowed_groups", [])
  access_package_reviewers = lookup(each.value, "access_package_reviewers", {
    devl = []
    nle  = []
    live = []
  })
  federated_identity_credentials = lookup(each.value, "federated_identity_credentials", [])
  application_template_name      = lookup(each.value, "application_template_name", null)
  app_role_assignment_required   = lookup(each.value, "app_role_assignment_required", true)
  account_enabled                = lookup(each.value, "account_enabled", true)
  hide                           = lookup(each.value, "hide", null)
}
