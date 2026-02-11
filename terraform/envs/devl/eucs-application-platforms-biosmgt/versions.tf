provider "azurerm" {
  use_oidc = true
  features {}
}

provider "azuread" {
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.14"
    }
  }
  backend "azurerm" {
    resource_group_name  = ""
    storage_account_name = ""
    container_name       = ""
    key                  = ""
    use_oidc             = true
  }
}
