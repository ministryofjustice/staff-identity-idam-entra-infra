data "azurerm_subscription" "primary" {}

data "azuread_client_config" "current" {}

data "azuread_application_template" "miro" {
  display_name = "Miro"
}
