resource "azuread_group" "tf_test" {
  display_name     = "Terraform-Test-Deployment"
  security_enabled = true
}
