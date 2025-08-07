locals {
  tags = {
    department = "eucs"
    team       = "idam"
    source     = "terraform"
  }
}

resource "azuread_group" "tf_test" {
  display_name     = "Terraform-Test-Deployment"
  security_enabled = true
}

resource "azurerm_key_vault" "internal_vault" {
  name                        = "internal-key-vault-devl"
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
