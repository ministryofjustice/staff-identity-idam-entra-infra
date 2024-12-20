data "azuread_user" "owners" {
  for_each = { for user in var.owners : user => user }
  user_principal_name = each.value
}

resource "azuread_application" "entra_app_reg" {
  display_name     = var.display_name
  owners           = values(data.azuread_user.owners).*.id
  sign_in_audience = "AzureADMyOrg"
  prevent_duplicate_names = true
  group_membership_claims = var.group_membership_claims

  app_role {
    allowed_member_types = ["User"]
    description          = "ReadOnly roles have limited query access"
    display_name         = "ReadOnly"
    enabled              = true
    id                   = "497406e4-012a-4267-bf18-45a1cb148a01"
    value                = "User"
  }

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