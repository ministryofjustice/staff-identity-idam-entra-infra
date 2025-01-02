locals {
  access_package_display_name = "app-${var.department_name}-${var.team_name}"
  catalog_display_name        = "app-${var.department_name}"
  roles                       = var.app_roles[*].display_name
}

data "azuread_user" "owners" {
  for_each            = { for user in var.owners : user => user }
  user_principal_name = each.value
}

resource "azuread_group" "access_package_sg_reviewers" {
  display_name     = "app-${var.department_name}-${var.team_name}-Reviewers"
  owners           = values(data.azuread_user.owners).*.object_id
  security_enabled = true
  members          = values(data.azuread_user.owners).*.object_id
}

resource "azuread_access_package_catalog" "access_package_catalog" {
  display_name = local.catalog_display_name
  description  = "Catalog for ${var.department_name} Applications"
}

resource "azuread_access_package" "access_package" {
  for_each     = { for role in local.roles : role => role }
  catalog_id   = azuread_access_package_catalog.access_package_catalog.id
  display_name = "${local.access_package_display_name}-${each.value}"
  description  = "Access Package for ${var.department_name}, ${var.team_name} to manage Application Access for ${var.application_name} as Role ${each.value}."
  hidden       = false
}

resource "azuread_access_package_assignment_policy" "package_policy" {
  for_each          = azuread_access_package.access_package
  access_package_id = each.value.id
  display_name      = "${local.access_package_display_name}-${each.key}-assignment-policy"
  description       = "Assignment policy for ${local.access_package_display_name} ${each.key}"
  duration_in_days  = 365
  extension_enabled = true

  requestor_settings {
    scope_type        = "AllExistingDirectoryMemberUsers"
    requests_accepted = true
  }

  approval_settings {
    approval_required = true

    approval_stage {
      approval_timeout_in_days = 14

      primary_approver {
        object_id    = azuread_group.access_package_sg_reviewers.object_id
        subject_type = "groupMembers"
      }
    }
  }

  assignment_review_settings {
    enabled                        = true
    review_frequency               = "halfyearly"
    duration_in_days               = 175
    review_type                    = "Reviewers"
    access_review_timeout_behavior = "keepAccess"

    reviewer {
      object_id    = azuread_group.access_package_sg_reviewers.object_id
      subject_type = "groupMembers"
    }
  }
}
/* Disabled until bug fix for Graph is released to allow association
resource "azuread_access_package_resource_catalog_association" "access_package_application" {
  catalog_id             = azuread_access_package_catalog.access_package_catalog.id
  resource_origin_id     = var.application_id
  resource_origin_system = "AadApplication"
}

resource "azuread_access_package_resource_package_association" "access_package_catalog_application" {
  access_package_id               = azuread_access_package.access_package.id
  catalog_resource_association_id = azuread_access_package_resource_catalog_association.access_package_application.id
}
*/
