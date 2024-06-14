terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~>2.7"
    }
  }
}

provider "azuread" {
  tenant_id     = var.tenant_id
  client_id     = var.client_id
  client_secret = var.client_secret
}

data "azuread_client_config" "current" {}
