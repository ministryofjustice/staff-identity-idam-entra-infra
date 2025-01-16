terraform {
    backend "azurerm" {
    resource_group_name  = "rg-eucs-idam-observability"
    storage_account_name = "steucsidamentratf"
    container_name       = "tfstate-env"
    key                  = "terraform.tfstate"
  }
}
