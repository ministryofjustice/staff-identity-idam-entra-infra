data "azuread_user" "owners" {
  for_each            = { for user in var.owners : user => user }
  user_principal_name = each.value
}

data "azuread_application_published_app_ids" "well_known" {}

resource "azuread_service_principal" "msgraph" {
  client_id    = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph
  use_existing = true
}

resource "azuread_application" "entra_app_reg" {
  display_name                 = var.display_name
  notes                        = var.notes
  service_management_reference = var.service_management_reference
  owners                       = values(data.azuread_user.owners).*.id
  sign_in_audience             = "AzureADMyOrg"
  prevent_duplicate_names      = true

  required_resource_access {
    resource_app_id = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph

    dynamic "resource_access" {
      for_each = { for role_perm in var.required_resource_access_roles : role_perm => role_perm }
      content {
        id   = azuread_service_principal.msgraph.app_role_ids[resource_access.value]
        type = "Role"
      }
    }

    dynamic "resource_access" {
      for_each = { for scope_perm in var.required_resource_access_scopes : scope_perm => scope_perm }
      content {
        id   = azuread_service_principal.msgraph.oauth2_permission_scope_ids[resource_access.value]
        type = "Scope"
      }
    }
  }

  web {
    homepage_url  = var.homepage_url
    logout_url    = var.logout_url
    redirect_uris = var.redirect_uris

    implicit_grant {
      access_token_issuance_enabled = true
      id_token_issuance_enabled     = true
    }
  }
}

resource "azuread_application_app_role" "entra_app_roles" {
  for_each             = var.app_roles
  allowed_member_types = each.value.allowed_member_types
  description          = each.value.description
  display_name         = each.value.display_name
  value                = each.value.value

  application_id = azuread_application.entra_app_reg.id
  role_id        = each.value.id
}
