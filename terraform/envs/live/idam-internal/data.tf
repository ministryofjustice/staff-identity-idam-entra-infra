data "azurerm_subscription" "primary" {}

data "azuread_client_config" "current" {}

data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "internal-rg" {
  name = "rg-eucs-idam-observability-pipeline"
}
