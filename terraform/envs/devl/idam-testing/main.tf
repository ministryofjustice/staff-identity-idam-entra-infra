locals {
  tags = {
    department = "eucs"
    team       = "idam"
    source     = "terraform"
  }
}

resource "azuread_group" "tf_test" {
  display_name     = "Terraform-Test-Deployment-Idam-Testing"
  security_enabled = true
}
