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
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  use_oidc        = true
  subscription_id = var.state_subscription_id
  tenant_id       = var.state_tenant_id
  client_id       = var.state_client_id
}

data "azurerm_subscription" "primary" {
}

provider "azuread" {
  tenant_id     = var.tenant_id
  client_id     = var.client_id
  client_secret = var.client_secret
}

data "azuread_client_config" "current" {}

locals {
  tags = {
    department = var.department
    team       = var.team
    source     = "terraform"
  }
}
