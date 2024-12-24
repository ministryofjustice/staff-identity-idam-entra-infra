locals {
  access_package_name = "MoJO-Admin-${var.department_name}-${var.team_name}"
}

resource "azuread_directory_role" "roles" {
  for_each     = { for role in var.roles : role => role }
  display_name = each.value
}

resource "azuread_group" "admin_access_package_sg_reviewers" {
  display_name            = "${local.access_package_name}-Reviewers"
  description             = "Reviewer group for ${local.access_package_name}"
  security_enabled        = true
  prevent_duplicate_names = true
  visibility              = "Private"
}

resource "azuread_group" "admin_access_package_sg_pim" {
  display_name            = "${local.access_package_name}-PIM"
  description             = "PIM Group for ${local.access_package_name}"
  security_enabled        = true
  prevent_duplicate_names = true
  visibility              = "Private"
  assignable_to_role      = true
}

resource "azuread_access_package" "admin_access_package" {
  catalog_id   = var.catalogue_id
  display_name = local.access_package_name
  description  = "Access Package for ${var.department_name} ${var.team_name} ${var.role_name}."

  depends_on = [
    azuread_group.admin_access_package_sg_reviewers,
    azuread_group.admin_access_package_sg_pim
  ]
}

resource "azuread_access_package_assignment_policy" "admin_package_policy" {
  access_package_id = azuread_access_package.admin_access_package.id
  display_name      = "initial-policy"
  description       = "Assignment policy for ${local.access_package_name}"
  duration_in_days  = 365

  requestor_settings {
    scope_type = "AllExistingDirectoryMemberUsers"
  }

  approval_settings {
    approval_required = true

    approval_stage {
      approval_timeout_in_days = 14

      primary_approver {
        object_id    = azuread_group.admin_access_package_sg_reviewers.object_id
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
      object_id    = azuread_group.admin_access_package_sg_reviewers.object_id
      subject_type = "groupMembers"
    }
  }

  depends_on = [
    azuread_access_package.admin_access_package
  ]
}

resource "azuread_access_package_resource_catalog_association" "admin_access_package_group_pim" {
  catalog_id             = var.catalogue_id
  resource_origin_id     = azuread_group.admin_access_package_sg_pim.object_id
  resource_origin_system = "AadGroup"

  depends_on = [
    azuread_access_package_assignment_policy.admin_package_policy
  ]
}

resource "azuread_access_package_resource_package_association" "admin_access_package_catalog_group_pim" {
  access_package_id               = azuread_access_package.admin_access_package.id
  catalog_resource_association_id = azuread_access_package_resource_catalog_association.admin_access_package_group_pim.id

  depends_on = [
    azuread_access_package_assignment_policy.admin_package_policy
  ]
}

resource "azuread_directory_role_eligibility_schedule_request" "group_role_assignment_eligible" {
  for_each           = azuread_directory_role.roles
  role_definition_id = each.value.template_id
  principal_id       = azuread_group.admin_access_package_sg_pim.object_id
  directory_scope_id = "/"
  justification      = "Example"

  depends_on = [
    azuread_access_package_resource_package_association.admin_access_package_catalog_group_pim
  ]
}
