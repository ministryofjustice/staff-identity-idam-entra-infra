locals {
  app_registration_list = {
    "eucs-idam-tf-test-app-reg" = {
      display_name                 = "eucs-idam-tf-test-app-reg"
      notes                        = "Test IDAM Team Terraform Test 1"
      service_management_reference = "SCTASK0000123"
      owners                       = ["jnolan-admin@devl.justice.gov.uk", "IDAMTestUser1@devl.justice.gov.uk"]
      homepage_url                 = "https://example.com"
      logout_url                   = "https://example.com/logout"
      redirect_uris                = ["https://example.com/account"]
      group_membership_claims      = ["None"]
    },
    "eucs-idam-tf-test-app-reg2" = {
      display_name                 = "eucs-idam-tf-test-app-reg2"
      notes                        = "Test IDAM Team Terraform Test 2"
      service_management_reference = "SCTASK0000123"
      owners                       = ["jnolan-admin@devl.justice.gov.uk", "IDAMTestUser1@devl.justice.gov.uk"]
      homepage_url                 = "https://example.com"
      logout_url                   = "https://example.com/logout"
      redirect_uris                = ["https://example.com/account"]
      group_membership_claims      = ["SecurityGroup"]
    }
  }
}
