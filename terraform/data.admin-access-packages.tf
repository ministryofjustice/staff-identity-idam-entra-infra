locals {
  admin_access_packages = {
    MoJO_Admin_EUCS_Security = {
      team_name       = "Security"
      department_name = "EUCS"
      role_name       = "Engineers"

      roles            = ["Security Reader", "Reports Reader"]
      tenants_required = ["DEVL", "NLE"]
    }
  }
}
