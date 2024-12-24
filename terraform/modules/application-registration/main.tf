locals {
  display_name = "${var.department_name}-${var.team_name}-${var.application_name}"
}

data "azuread_user" "owners" {
  for_each            = { for user in var.owners : user => user }
  user_principal_name = each.value
}

data "azuread_group" "groups" {
  for_each     = { for group in var.allowed_groups : group => group }
  display_name = each.value
}

data "azuread_application_published_app_ids" "well_known" {}

resource "azuread_service_principal" "msgraph" {
  client_id    = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph
  use_existing = true
}

resource "azuread_application" "entra_app_reg" {
  display_name                 = local.display_name
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

  dynamic "app_role" {
    for_each = var.app_roles
    content {
      allowed_member_types = app_role.value.allowed_member_types
      description          = app_role.value.description
      display_name         = app_role.value.display_name
      value                = app_role.value.value
      enabled              = true
      id                   = app_role.value.id
    }
  }

  app_role {
    allowed_member_types = ["Application", "User"]
    description          = "Standard internal users role for Group assignment"
    display_name         = "Internal.User"
    enabled              = true
    id                   = "00000000-0000-0000-0000-222222222222"
    value                = "Internal.User"
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

resource "azuread_service_principal" "entra_app_service_principle" {
  client_id                    = azuread_application.entra_app_reg.client_id
  app_role_assignment_required = true
  owners                       = values(data.azuread_user.owners).*.id

  feature_tags {
    enterprise = true
    gallery    = false
  }
}

resource "azuread_app_role_assignment" "internal_allowed_groups" {
  for_each            = data.azuread_group.groups
  app_role_id         = azuread_service_principal.entra_app_service_principle.app_role_ids["Internal.User"]
  principal_object_id = each.value.object_id
  resource_object_id  = azuread_service_principal.entra_app_service_principle.object_id

  depends_on = [
    azuread_application.entra_app_reg,
    azuread_service_principal.entra_app_service_principle
  ]
}

module "application-registration-access-package" {
  source = "../application-registration-access-package"
  count  = var.create_access_package == true ? 1 : 0

  department_name  = var.department_name
  team_name        = var.team_name
  application_name = var.application_name

  owners         = var.owners
  app_roles      = var.app_roles
  application_id = azuread_application.entra_app_reg.id

  depends_on = [
    azuread_application.entra_app_reg,
    azuread_service_principal.entra_app_service_principle
  ]
}
