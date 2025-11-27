locals {
  tags = {
    department = "eucs"
    team       = "idam"
    source     = "terraform"
  }
}

resource "azurerm_key_vault" "idam-internal_vault" {
  name                        = "kv-internal-idam-nle"
  location                    = data.azurerm_resource_group.internal-rg.location
  resource_group_name         = data.azurerm_resource_group.internal-rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}

resource "azurerm_key_vault_access_policy" "example" {
  for_each = var.engineer_object_ids

  key_vault_id = azurerm_key_vault.idam-internal_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = each.value

  key_permissions = [
    "Get",
  ]

  secret_permissions = [
    "Get",
  ]
}

module "application-registration" {
  source                         = "../../../modules/application-registrationV1.2.0"
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
  mobile_desktop_redirect_uris   = each.value.mobile_desktop_redirect_uris
  app_roles                      = each.value.app_roles
  graph_application_permissions  = each.value.graph_application_permissions
  graph_delegated_permissions    = each.value.graph_delegated_permissions
  tenants_required               = each.value.tenants_required
  federated_identity_credentials = each.value.federated_identity_credentials
  service_principle              = each.value.service_principle
  identifier_uris                = each.value.identifier_uris
}
#endregion