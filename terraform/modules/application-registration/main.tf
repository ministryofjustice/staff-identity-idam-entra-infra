locals {
  display_name = "${var.department_name}-${var.team_name}-${var.application_name}"
  owners       = terraform.workspace == "LIVE" ? var.access_package_reviewers.live : terraform.workspace == "NLE" ? var.access_package_reviewers.nle : var.access_package_reviewers.devl
}

data "azuread_groups" "groups" {
  display_names    = var.allowed_groups
  security_enabled = true
}

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
  display_name                 = local.display_name
  notes                        = "${var.notes}\n\nManaged by IDAM Entra Infra Terraform"
  service_management_reference = var.service_management_reference
  owners                       = values(data.azuread_user.owners).*.object_id
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
  owners                       = values(data.azuread_user.owners).*.object_id

  feature_tags {
    enterprise = true
    gallery    = false
  }
}

resource "azuread_app_role_assignment" "internal_allowed_groups" {
  for_each            = { for x in data.azuread_groups.groups.object_ids : x => x }
  app_role_id         = azuread_service_principal.entra_app_service_principle.app_role_ids["Internal.User"]
  principal_object_id = each.value
  resource_object_id  = azuread_service_principal.entra_app_service_principle.object_id

  depends_on = [
    azuread_application.entra_app_reg,
    azuread_service_principal.entra_app_service_principle
  ]
}

resource "azuread_application_federated_identity_credential" "federated_credentials" {
  for_each       = { for cred in var.federated_identity_credentials : cred.subject_suffix => cred }
  application_id = azuread_application.entra_app_reg.id
  display_name   = "${each.value.repo_name}-${each.value.subject_suffix}"
  description    = each.value.description
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = "repo:my-organization/${each.value.repo_name}:${each.value.subject_suffix}"

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

  owners         = local.owners
  app_roles      = var.app_roles
  application_id = azuread_application.entra_app_reg.id

  depends_on = [
    azuread_application.entra_app_reg,
    azuread_service_principal.entra_app_service_principle
  ]
}
