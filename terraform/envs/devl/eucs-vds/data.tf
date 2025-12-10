data "azurerm_subscription" "primary" {}

data "azuread_client_config" "current" {}

data "azuread_application" "Nerdio-API" {
    display_name = "MoJ-OFFICIAL-Devl-EUCS-VDS-Nerdio-API"
}
