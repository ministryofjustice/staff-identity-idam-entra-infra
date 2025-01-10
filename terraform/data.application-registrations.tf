locals {
  app_registration_list = [
    {
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
      redirect_uris = {
        devl = ["https://example.com/account"]
        nle  = ["https://example.com/account"]
        live = ["https://example.com/account"]
      }
      tenants_required = ["DEVL", "NLE", "LIVE"]

      graph_delegated_permissions = ["User.Read"]

      allowed_groups = ["MoJO - Users - All"]
    },
    {
      display_name                 = "EUCS IDAM App Reg Test 2 (App Roles)"
      department_name              = "eucs"
      team_name                    = "idam"
      application_name             = "app-reg-2"
      notes                        = "Example IDAM Team Terraform Test 2"
      service_management_reference = ""
      owners_devl                  = ["jnolan-admin@devl.justice.gov.uk", "IDAMTestUser1@devl.justice.gov.uk"]
      owners_nle                   = ["testuser01@test.justice.gov.uk", "testuser02@test.justice.gov.uk"]
      owners_live                  = ["john.nolan@justice.gov.uk", "arron.ruecroft2@justice.gov.uk"]
      homepage_url                 = "https://examples.com"
      logout_url                   = "https://examples.com/logout"
      redirect_uris = {
        devl = ["https://example.com/account"]
        nle  = ["https://example.com/account"]
        live = ["https://example.com/account"]
      }
      tenants_required = ["DEVL"]

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
    {
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
      redirect_uris = {
        devl = ["https://example.com/account"]
        nle  = ["https://example.com/account"]
        live = ["https://example.com/account"]
      }
      tenants_required = ["DEVL"]

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
    {
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
      redirect_uris = {
        devl = ["https://accounts.google.com/samlrp/047gzjif17t5ybk/acs"]
        nle  = ["https://accounts.google.com/samlrp/03f6vr1n0hxwhz4/acs"]
        live = null
      }
      identifier_uris = {
        devl = ["https://accounts.google.com/samlrp/047gzjif17t5ybk"]
        nle  = ["https://accounts.google.com/samlrp/03f6vr1n0hxwhz4"]
        live = null
      }
      tenants_required = ["DEVL", "NLE"]

      allowed_groups = ["google-cloud-allowed"]

      graph_delegated_permissions   = ["User.Read"]
      graph_application_permissions = ["User.Read.All", "GroupMember.Read.All"]

      service_principle = {
        application_template_name     = "Google Cloud / G Suite Connector by Microsoft"
        login_url                     = "https://www.google.com/a/test.digital.justice.gov.uk/ServiceLogin?continue=https://console.cloud.google.com/"
        notification_email_addresses  = ["idamteam@justice.gov.uk"]
        preferred_single_sign_on_mode = "saml"
        hide                          = false
        app_role_assignment_required  = true
        account_enabled               = true
      }
    },
    {
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
      redirect_uris = {
        devl = ["https://example.com/account"]
        nle  = ["https://example.com/account"]
        live = ["https://example.com/account"]
      }
      tenants_required = ["DEVL", "NLE"]

      graph_delegated_permissions = ["User.Read"]

      service_principle = {
        application_template_name     = "Google Cloud / G Suite Connector by Microsoft"
        login_url                     = null
        notification_email_addresses  = []
        preferred_single_sign_on_mode = null
        hide                          = true
        app_role_assignment_required  = false
        account_enabled               = false
      }
    },
  ]
}
