module "application-registration" {
  source = "./modules/application-registration"

  for_each = local.app_registration_list

  display_name            = each.value.display_name
  owners                  = each.value.owners
  homepage_url            = each.value.homepage_url
  logout_url              = each.value.logout_url
  redirect_uris           = each.value.redirect_uris
  group_membership_claims = each.value.group_membership_claims
}
