provider "azurerm" {
  use_oidc = true
  tenant_id     = var.tenant_id
  client_id     = var.client_id
  client_secret = var.client_secret
  features {}
}

provider "azuread" {
  # tenant_id     = var.tenant_id
  # client_id     = var.client_id
  # client_secret = var.client_secret
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.14"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-eucs-idam-observability"
    storage_account_name = "stidamobservetfstate"
    container_name       = "tfstate-env"
    key                  = "terraform.tfstate"
    use_oidc             = true
  }
}
