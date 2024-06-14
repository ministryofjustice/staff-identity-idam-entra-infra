terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~>2.7"
    }
  }
}

provider "azuread" {
  features {}

  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  client_secret   = var.client_secret
}

locals {
  rg_name = "rg-${var.department}-${var.team}-${var.project}"
  tags = {
    department = var.department
    team       = var.team
    project    = var.project
    source     = "terraform"
  }
}
