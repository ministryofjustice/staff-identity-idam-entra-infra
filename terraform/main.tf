locals {
  app_registrations = { for s in local.app_registration_list : s.display_name => s }
}

module "application-registration" {
  source = "./modules/application-registration"

  for_each = { for s, v in local.app_registrations : s => v if contains(v.tenants_required, terraform.workspace) }

  display_name                 = each.value.display_name
  department_name              = each.value.department_name
  team_name                    = each.value.team_name
  application_name             = each.value.application_name
  create_access_package        = lookup(each.value, "create_access_package", false)
  service_management_reference = each.value.service_management_reference
  notes                        = each.value.notes
  owners                       = terraform.workspace == "LIVE" ? each.value.owners_live : terraform.workspace == "NLE" ? lookup(each.value, "owners_nle", []) : lookup(each.value, "owners_devl", [])
  homepage_url                 = each.value.homepage_url
  logout_url                   = each.value.logout_url
  redirect_uris = lookup(each.value, "redirect_uris", {
    devl = null
    nle  = null
    live = null
  })
  identifier_uris = lookup(each.value, "identifier_uris", {
    devl = null
    nle  = null
    live = null
  })
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
  service_principle = lookup(each.value, "service_principle", {
    login_url                     = lookup(each.value, "login_url", null),
    notification_email_addresses  = lookup(each.value, "notification_email_addresses", []),
    preferred_single_sign_on_mode = lookup(each.value, "preferred_single_sign_on_mode", null),
    app_role_assignment_required  = lookup(each.value, "app_role_assignment_required", true)
    account_enabled               = lookup(each.value, "account_enabled", true),
    application_template_name     = lookup(each.value, "application_template_name", null),
    hide                          = lookup(each.value, "hide", null)
  })
}
