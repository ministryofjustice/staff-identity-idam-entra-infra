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
