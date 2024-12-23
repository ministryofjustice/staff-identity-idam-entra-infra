data "azuread_user" "owners" {
  for_each            = { for user in var.owners : user => user }
  user_principal_name = each.value
}

resource "azuread_application" "entra_app_reg" {
  display_name                 = var.display_name
  notes                        = var.notes
  service_management_reference = var.service_management_reference
  owners                       = values(data.azuread_user.owners).*.id
  sign_in_audience             = "AzureADMyOrg"
  prevent_duplicate_names      = true

  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph

    resource_access {
      id   = "df021288-bdef-4463-88db-98f22de89214" # User.Read.All
      type = "Role"
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
