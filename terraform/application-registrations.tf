locals {
  app_registration_list = {
    eucs_idam_tf_test_app_reg = {
      display_name                 = "eucs-idam-tf-test-app-reg"
      notes                        = "Test IDAM Team Terraform Test 1"
      service_management_reference = "SCTASK0000123"
      owners                       = ["jnolan-admin@devl.justice.gov.uk", "IDAMTestUser1@devl.justice.gov.uk"]
      homepage_url                 = "https://example.com"
      logout_url                   = "https://example.com/logout"
      redirect_uris                = ["https://example.com/account"]
      app_roles                    = {}

      required_resource_access_scopes = ["User.Read"]
      required_resource_access_roles  = []
    },
    eucs_idam_tf_test_app_reg2 = {
      display_name                 = "eucs-idam-tf-test-app-reg2"
      notes                        = "Test IDAM Team Terraform Test 2"
      service_management_reference = ""
      owners                       = ["jnolan-admin@devl.justice.gov.uk", "IDAMTestUser1@devl.justice.gov.uk"]
      homepage_url                 = "https://example.com"
      logout_url                   = "https://example.com/logout"
      redirect_uris                = ["https://example.com/account"]

      required_resource_access_roles  = ["User.Read.All"]
      required_resource_access_scopes = ["User.Read", "User.ReadWrite"]

      app_roles = {
        read_only = {
          allowed_member_types = ["User"]
          description          = "ReadOnly roles have limited query access"
          display_name         = "ReadOnly"
          id                   = "${random_uuid.eucs_idam_tf_test_app_reg2_readonly.result}"
          value                = "User"
        },
        admin = {
          allowed_member_types = ["User"]
          description          = "Administrator roles"
          display_name         = "Administrator"
          id                   = "${random_uuid.eucs_idam_tf_test_app_reg2_admin.result}"
          value                = "Admin"
        }
      }
    }
  }
}
