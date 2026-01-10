locals {
  tags = {
    department = "eucs"
    team       = "idam"
    source     = "terraform"
  }
}

resource "azuread_group" "tf_test" {
  display_name     = "Terraform-Test-Deployment-Idam-Testing"
  security_enabled = true
}

#region Application Registrations
module "application-registration" {
  source                         = "../../../modules/application-registrationV1"
  for_each                       = var.applications
  notes                          = each.value.notes
  service_management_reference   = each.value.service_management_reference
  display_name                   = each.value.display_name
  department_name                = each.value.department_name
  team_name                      = each.value.team_name
  application_name               = each.value.application_name
  create_access_package          = each.value.create_access_package
  access_package_reviewers       = each.value.access_package_reviewers
  owners                         = each.value.owners
  allowed_groups                 = each.value.allowed_groups
  homepage_url                   = each.value.homepage_url
  logout_url                     = each.value.logout_url
  redirect_uris                  = each.value.redirect_uris
  app_roles                      = each.value.app_roles
  graph_application_permissions  = each.value.graph_application_permissions
  graph_delegated_permissions    = each.value.graph_delegated_permissions
  tenants_required               = each.value.tenants_required
  federated_identity_credentials = each.value.federated_identity_credentials
  service_principle              = each.value.service_principle
  identifier_uris                = each.value.identifier_uris
}
#endregion

#region cert testing
resource "azurerm_key_vault" "idam_testing" {
  name                        = "kv-idam-testing-certs"
  location                    = data.azurerm_resource_group.internal_rg.location
  resource_group_name         = data.azurerm_resource_group.internal_rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
}

resource "azurerm_key_vault_access_policy" "idam_testing" {
  key_vault_id = azurerm_key_vault.idam_testing.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.automation.id

  
  certificate_permissions = [
    "Get",
    "List"
  ]

  secret_permissions = [
    "Get"
  ]
}


resource "azurerm_key_vault_certificate" "runbook_test" {
  name         = "app-runbook-ps"
  key_vault_id = azurerm_key_vault.idam_testing.id

  certificate_policy {
    issuer_parameters {
      name = "Self"
    }

    key_properties {
      exportable = false
      key_size   = 2048
      key_type   = "RSA"
      reuse_key  = true
    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }

    x509_certificate_properties {
      subject            = "CN=AppAuthCert"
      validity_in_months = 12
      key_usage = [
        "digitalSignature",
        "keyEncipherment",
      ]
      extended_key_usage = [
        "clientAuth",
      ]
    }

    lifetime_action {
      action {
        action_type = "AutoRenew"
      }

      trigger {
        days_before_expiry = 30
      }
    }
  }
}


resource "azurerm_user_assigned_identity" "automation" {
  location            = data.azurerm_resource_group.internal_rg.location
  name                = "idam-testing-automation"
  resource_group_name = data.azurerm_resource_group.internal_rg.name
}

#endregion
