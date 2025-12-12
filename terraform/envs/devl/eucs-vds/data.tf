data "azurerm_subscription" "primary" {}

data "azuread_client_config" "current" {}

data "azuread_service_principal" "nerdio_api" {
  client_id = local.nerdio_api_app_id
}
