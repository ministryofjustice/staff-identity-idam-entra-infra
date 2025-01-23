provider "azurerm" {
  use_oidc = true
  features {}
}

provider "azuread" {
}

terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~>3.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.14"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-eucs-idam-observability"
    storage_account_name = "steucsidamentratf"
    container_name       = "tfstate-env"
    key                  = "terraform.tfstate"
    use_oidc             = true
  }
}
