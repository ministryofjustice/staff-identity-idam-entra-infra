locals {
  app_registration_list = [
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
        live = ["https://accounts.google.com/samlrp/03ddmehe2teh9fk/acs"]
      }
      identifier_uris = {
        devl = ["https://accounts.google.com/samlrp/047gzjif17t5ybk"]
        nle  = ["https://accounts.google.com/samlrp/03f6vr1n0hxwhz4"]
        live = ["https://accounts.google.com/samlrp/03ddmehe2teh9fk"]
      }
      tenants_required = ["DEVL", "NLE", "LIVE"]

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
      tenants_required = ["DEVL", "NLE", "LIVE"]

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
