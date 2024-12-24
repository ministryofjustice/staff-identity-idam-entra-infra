resource "azuread_access_package_catalog" "admin_access_package_catalog" {
  display_name       = "MoJ-OFFICIAL-Administrative-Roles"
  description        = "Administrative Roles for MoJ OFFICIAL Entitlement Management"
  externally_visible = false
  published          = true
}