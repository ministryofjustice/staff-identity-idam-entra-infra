locals {
  app_registration_list = {
    eucs_idam_tf_test_app_reg = {
      display_name                 = "EUCS IDAM App Reg Test 1"
      department_name              = "eucs"
      team_name                    = "idam"
      application_name             = "app-reg"
      notes                        = "Example IDAM Team Terraform Test 1"
      service_management_reference = "SCTASK0000123"
      owners_devl                  = ["jnolan-admin@devl.justice.gov.uk", "IDAMTestUser1@devl.justice.gov.uk"]
      owners_nle                   = ["testuser01@test.justice.gov.uk", "testuser02@test.justice.gov.uk"]
      owners_live                  = ["john.nolan@justice.gov.uk", "arron.ruecroft2@justice.gov.uk"]
      homepage_url                 = "https://example.com"
      logout_url                   = "https://example.com/logout"
      redirect_uris                = ["https://example.com/account"]
      tenants_required             = ["DEVL", "NLE", "LIVE"]

      graph_delegated_permissions = ["User.Read"]

      allowed_groups = ["MoJO - Users - All"]
    },
    eucs_idam_tf_test_app_reg2 = {
      display_name                 = "EUCS IDAM App Reg Test 2 (App Roles)"
      department_name              = "eucs"
      team_name                    = "idam"
      application_name             = "app-reg-2"
      notes                        = "Example IDAM Team Terraform Test 2"
      service_management_reference = ""
      owners_devl                  = ["jnolan-admin@devl.justice.gov.uk", "IDAMTestUser1@devl.justice.gov.uk"]
      owners_nle                   = ["testuser01@test.justice.gov.uk", "testuser02@test.justice.gov.uk"]
      owners_live                  = ["john.nolan@justice.gov.uk", "arron.ruecroft2@justice.gov.uk"]
      homepage_url                 = "https://example.com"
      logout_url                   = "https://example.com/logout"
      redirect_uris                = ["https://example.com/account"]
      tenants_required             = ["DEVL"]

      graph_application_permissions = ["User.Read.All"]
      graph_delegated_permissions   = ["User.Read", "User.ReadWrite"]

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
      display_name                 = "EUCS IDAM App Reg Test 3 (Federation)"
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

      graph_delegated_permissions = ["User.Read"]
    },
    eucs_idam_google_cloud = {
      display_name                 = "Google Cloud"
      department_name              = "eucs"
      team_name                    = "idam"
      application_name             = "google-cloud"
      notes                        = "Google Cloud Identity Federation Integration"
      service_management_reference = "IDAM-1702"
      owners_devl                  = ["jnolan-admin@devl.justice.gov.uk"]
      owners_live                  = ["john.nolan@justice.gov.uk", "arron.ruecroft2@justice.gov.uk"]
      homepage_url                 = "https://example.com"
      logout_url                   = "https://example.com/logout"
      redirect_uris                = ["https://example.com/account"]
      tenants_required             = ["DEVL", "NLE"]
      application_template_name    = "Google Cloud / G Suite Connector by Microsoft"

      allowed_groups = ["google-cloud-allowed"]

      graph_delegated_permissions   = ["User.Read"]
      graph_application_permissions = ["User.Read.All", "GroupMember.Read.All"]
    },
    eucs_idam_google_cloud_provisioning = {
      display_name                 = "Google Cloud (Provisioning)"
      department_name              = "eucs"
      team_name                    = "idam"
      application_name             = "google-cloud-provisioning"
      notes                        = "Google Cloud Identity Provisioning Integration"
      service_management_reference = "IDAM-1701"
      owners_devl                  = ["jnolan-admin@devl.justice.gov.uk"]
      owners_live                  = ["john.nolan@justice.gov.uk", "arron.ruecroft2@justice.gov.uk"]
      homepage_url                 = "https://example.com"
      logout_url                   = "https://example.com/logout"
      redirect_uris                = ["https://example.com/account"]
      tenants_required             = ["DEVL", "NLE"]
      application_template_name    = "Google Cloud / G Suite Connector by Microsoft"

      graph_delegated_permissions = ["User.Read"]

      hide                         = true
      app_role_assignment_required = false
      account_enabled              = false
    },
  }
}
