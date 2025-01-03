locals {
  app_registration_list = {
    eucs_idam_tf_test_app_reg = {
      department_name                = "eucs"
      team_name                      = "idam"
      application_name               = "app-reg"
      notes                          = "Example IDAM Team Terraform Test 1"
      service_management_reference   = "SCTASK0000123"
      owners_devl                    = ["jnolan-admin@devl.justice.gov.uk", "IDAMTestUser1@devl.justice.gov.uk"]
      owners_nle                     = ["testuser01@test.justice.gov.uk", "testuser02@test.justice.gov.uk"]
      owners_live                    = ["john.nolan@justice.gov.uk", "arron.ruecroft2@justice.gov.uk"]
      homepage_url                   = "https://example.com"
      logout_url                     = "https://example.com/logout"
      redirect_uris                  = ["https://example.com/account"]
      app_roles                      = []
      tenants_required               = ["DEVL", "NLE", "LIVE"]
      federated_identity_credentials = []

      required_resource_access_scopes = ["User.Read"]
      required_resource_access_roles  = []

      allowed_groups = ["MoJO - Users - All"]

      create_access_package = false
      access_package_reviewers = {
        devl = []
        nle  = []
        live = []
      }
    },
    eucs_idam_tf_test_app_reg2 = {
      department_name                = "eucs"
      team_name                      = "idam"
      application_name               = "app-reg-2"
      notes                          = "Example IDAM Team Terraform Test 2"
      service_management_reference   = ""
      owners_devl                    = ["jnolan-admin@devl.justice.gov.uk", "IDAMTestUser1@devl.justice.gov.uk"]
      owners_nle                     = ["testuser01@test.justice.gov.uk", "testuser02@test.justice.gov.uk"]
      owners_live                    = ["john.nolan@justice.gov.uk", "arron.ruecroft2@justice.gov.uk"]
      homepage_url                   = "https://example.com"
      logout_url                     = "https://example.com/logout"
      redirect_uris                  = ["https://example.com/account"]
      tenants_required               = ["DEVL"]
      federated_identity_credentials = []

      required_resource_access_roles  = ["User.Read.All"]
      required_resource_access_scopes = ["User.Read", "User.ReadWrite"]

      allowed_groups = []

      create_access_package = true
      access_package_reviewers = {
        devl = ["jnolan-admin@devl.justice.gov.uk", "IDAMTestUser1@devl.justice.gov.uk"]
        nle  = ["testuser01@test.justice.gov.uk", "testuser02@test.justice.gov.uk"]
        live = ["john.nolan@justice.gov.uk", "arron.ruecroft2@justice.gov.uk"]
      }

      app_roles = [
        {
          allowed_member_types  = ["User"]
          description           = "ReadOnly roles have limited query access"
          display_name          = "ReadOnly"
          id                    = "${random_uuid.eucs_idam_tf_test_app_reg2_readonly.result}"
          value                 = "User"
          access_package_hidden = false
        },
        {
          allowed_member_types  = ["User"]
          description           = "Administrator roles"
          display_name          = "Administrator"
          id                    = "${random_uuid.eucs_idam_tf_test_app_reg2_admin.result}"
          value                 = "Admin"
          access_package_hidden = true
        }
      ]
    },
    eucs_idam_tf_app_reg_fed_identitity = {
      department_name              = "eucs"
      team_name                    = "idam"
      application_name             = "federated-identity"
      notes                        = "Example IDAM Team Terraform Test Federated Identity"
      service_management_reference = "SCTASK0000123"
      owners_devl                  = ["jnolan-admin@devl.justice.gov.uk", "IDAMTestUser1@devl.justice.gov.uk"]
      owners_nle                   = ["testuser01@test.justice.gov.uk", "testuser02@test.justice.gov.uk"]
      owners_live                  = ["john.nolan@justice.gov.uk", "arron.ruecroft2@justice.gov.uk"]
      homepage_url                 = "https://example.com"
      logout_url                   = "https://example.com/logout"
      redirect_uris                = ["https://example.com/account"]
      app_roles                    = []
      tenants_required             = ["DEVL"]

      federated_identity_credentials = [
        {
          repo_name      = "staff-identity-idam-entra-infra"
          display_name   = "staff-identity-idam-entra-infra-branch"
          description    = "Example federated credential to staff-identity-idam-entra-infra branch example-federated."
          subject_suffix = "ref:refs/heads/example-federated"
        },
        {
          repo_name      = "staff-identity-idam-entra-infra"
          display_name   = "staff-identity-idam-entra-infra-environment"
          description    = "Example federated credential to staff-identity-idam-entra-infra Environment example-federated."
          subject_suffix = "environment:example-federated"
        },
        {
          repo_name      = "staff-identity-idam-entra-infra"
          display_name   = "staff-identity-idam-entra-infra-tags"
          description    = "Example federated credential to staff-identity-idam-entra-infra Tag example-federated."
          subject_suffix = "ref:refs/tags/example-federated"
        },
        {
          repo_name      = "staff-identity-idam-entra-infra"
          display_name   = "staff-identity-idam-entra-infra-pull-request"
          description    = "Example federated credential to staff-identity-idam-entra-infra pull requests."
          subject_suffix = "pull_request"
        }
      ]

      required_resource_access_scopes = ["User.Read"]
      required_resource_access_roles  = []

      allowed_groups = []

      create_access_package = false
      access_package_reviewers = {
        devl = []
        nle  = []
        live = []
      }
    },
  }
}
