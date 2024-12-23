data "azuread_user" "owners" {
  for_each            = { for user in var.owners : user => user }
  user_principal_name = each.value
}

resource "azuread_group" "access_package_sg_reviewers" {
  display_name     = "${var.access_package_display_name}-Reviewers"
  owners           = values(data.azuread_user.owners).*.id
  security_enabled = true
  members          = values(data.azuread_user.owners).*.id
}

resource "azuread_access_package_catalog" "access_package_catalog" {
  display_name = var.catalog_display_name
  description  = var.catalog_description
}

resource "azuread_access_package" "access_package" {
  catalog_id   = azuread_access_package_catalog.access_package_catalog.id
  display_name = var.access_package_display_name
  description  = var.access_package_description
}

resource "azuread_access_package_assignment_policy" "package_policy" {
  access_package_id = azuread_access_package.access_package.id
  display_name      = "${var.access_package_display_name}-assignment-policy"
  description       = "Assignment policy for ${var.access_package_display_name}"
  duration_in_days  = 365

  requestor_settings {
    scope_type = "AllExistingDirectoryMemberUsers"
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
