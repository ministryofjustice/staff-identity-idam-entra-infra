variable "location" {
  description = "Azure region for resources to be deployed to."
  type        = string
  default     = "uksouth"
}

variable "applications" {
  description = "Map of application details"
  type = map(object({
    notes                         = string
    service_management_reference  = string
    display_name                  = string
    department_name               = string
    team_name                     = string
    application_name              = string
    create_access_package         = bool
    access_package_reviewers      = list(string)
    owners                        = list(string)
    application_contacts          = list(string)
    allowed_groups                = list(string)
    homepage_url                  = string
    logout_url                    = string
    redirect_uris                 = list(string)
    access_token_issuance_enabled = bool
    id_token_issuance_enabled     = bool
    mobile_desktop_redirect_uris  = list(string)
    app_roles = list(object({
      allowed_member_types  = list(string)
      description           = string
      display_name          = string
      id                    = string
      value                 = string
      access_package_hidden = bool
    }))
    graph_application_permissions = list(string)
    graph_delegated_permissions   = list(string)
    tenants_required              = list(string)
    federated_identity_credentials = list(object({
      repo_name      = string
      display_name   = string
      description    = string
      subject_suffix = string
    }))
    service_principle = object({
      login_url                     = string
      notification_email_addresses  = list(string)
      preferred_single_sign_on_mode = string
      app_role_assignment_required  = bool
      account_enabled               = bool
      application_template_name     = string
      hide                          = bool
      custom_single_sign_on         = bool
    })
    identifier_uris = list(string)
    api = object({
      known_client_applications      = list(string)
      mapped_claims_enabled          = bool
      requested_access_token_version = string
      oauth2_permission_scope = list(object({
        admin_consent_description  = string
        admin_consent_display_name = string
        enabled                    = bool
        id                         = string
        type                       = string
        user_consent_description   = string
        user_consent_display_name  = string
        value                      = string
      }))
    })
  }))
  default = {
    "app1" = {
      notes                          = "LAA Portal replacement application."
      service_management_reference   = "IDAM-2974"
      display_name                   = "LASSIE"
      department_name                = "justice-digital"
      team_name                      = "laa"
      application_name               = "LASSIE"
      create_access_package          = false
      access_package_reviewers       = []
      owners                         = ["John.nolan_JusticeUK.onmicrosoft.com#EXT#@TestJusticeUKExternal.onmicrosoft.com", "John.Nolan@TestJusticeUKExternal.onmicrosoft.com"]
      application_contacts           = ["john.nolan@justice.gov.uk", "Ben.Ashton@justice.gov.uk", "Eamon.McNally@justice.gov.uk"]
      allowed_groups                 = ["APPREG-User-Access-LAAD-LASSIE", "DEPT-All-Legal-Aid-Agency-Internal-Staff"]
      homepage_url                   = null
      logout_url                     = null
      redirect_uris                  = ["https://laa-landing-page-test.apps.live.cloud-platform.service.justice.gov.uk/login/oauth2/code/azure"]
      mobile_desktop_redirect_uris   = null
      app_roles                      = []
      graph_application_permissions  = ["CustomAuthenticationExtension.Receive.Payload", "User.Invite.All", "Directory.Read.All", "User.Read.All", "GroupMember.ReadWrite.All", "AuditLog.Read.All", "Application.Read.All"]
      graph_delegated_permissions    = ["User.Read", "User.RevokeSessions.All"]
      tenants_required               = ["NLEEXTERNAL"]
      access_token_issuance_enabled  = true
      id_token_issuance_enabled      = true
      federated_identity_credentials = []
      service_principle = {
        login_url                     = null
        notification_email_addresses  = []
        preferred_single_sign_on_mode = null
        app_role_assignment_required  = false
        account_enabled               = true
        application_template_name     = null
        hide                          = true
        custom_single_sign_on         = null
      }
      identifier_uris = ["api://laa-landing-page-test.apps.live.cloud-platform.service.justice.gov.uk/77595545-15fc-4d83-89d4-3e36387dafa9"]
      api = {
        known_client_applications      = [],
        mapped_claims_enabled          = false,
        requested_access_token_version = 1,
        oauth2_permission_scope = [{
          admin_consent_description  = "Allows the application to access the API on behalf of the signed-in user"
          admin_consent_display_name = "Access Claim Enrichment"
          enabled                    = true
          id                         = "5eff006b-3ee5-4038-a473-2fbc1443291a"
          type                       = "Admin"
          user_consent_description   = null
          user_consent_display_name  = null
          value                      = "user_impersonation"
        }]
      }
    },
    "apply_civil_legal_aid" = {
      notes                        = "Enables providers to submit an application for civil legal aid."
      service_management_reference = "IDAM-2974"
      display_name                 = "Apply for Civil Legal Aid"
      department_name              = "justice-digital"
      team_name                    = "laa"
      application_name             = "apply-for-civil-legal-aid"
      create_access_package        = false
      access_package_reviewers     = []
      owners                       = ["John.nolan_JusticeUK.onmicrosoft.com#EXT#@TestJusticeUKExternal.onmicrosoft.com", "John.Nolan@TestJusticeUKExternal.onmicrosoft.com"]
      application_contacts = [
        "Ben.Ashton@justice.gov.uk",
        "Eamon.McNally@justice.gov.uk",
        "joel.sugarman@justice.gov.uk",
        "colin.bruce1@justice.gov.uk",
        "adam.goldstone@justice.gov.uk",
        "stephanie.dejong@justice.gov.uk"
      ]
      allowed_groups = ["APPREG-User-Access-LAAD-Apply-Civil-Legal-Aid"]
      homepage_url   = "https://main-applyforlegalaid-uat.cloud-platform.service.justice.gov.uk/"
      logout_url     = null
      redirect_uris = [
        "https://main-applyforlegalaid-uat.cloud-platform.service.justice.gov.uk/auth/entra_id/callback",
        "https://staging.apply-for-legal-aid.service.justice.gov.uk/auth/entra_id/callback"
      ]
      mobile_desktop_redirect_uris   = null
      app_roles                      = []
      graph_application_permissions  = []
      graph_delegated_permissions    = ["User.Read"]
      tenants_required               = ["NLEEXTERNAL"]
      access_token_issuance_enabled  = true
      id_token_issuance_enabled      = true
      federated_identity_credentials = []
      service_principle = {
        login_url                     = null
        notification_email_addresses  = []
        preferred_single_sign_on_mode = null
        app_role_assignment_required  = true
        account_enabled               = true
        application_template_name     = null
        hide                          = true
        custom_single_sign_on         = null
      }
      identifier_uris = null
      api = {
        known_client_applications      = null,
        mapped_claims_enabled          = true,
        requested_access_token_version = 2,
        oauth2_permission_scope        = []
      }
    },
    "apply_criminal_legal_aid" = {
      notes                        = "Apply for criminal legal aid is a service enabling providers to apply for criminal legal aid online. It is used by provider firms to submit applications on behalf of their clients, to make changes to returned applications, to provide additional evidence or to make supplementary applications when a client's circumstance change."
      service_management_reference = "IDAM-2974"
      display_name                 = "Apply for Criminal Legal Aid"
      department_name              = "justice-digital"
      team_name                    = "laa"
      application_name             = "apply-for-criminal-legal-aid"
      create_access_package        = false
      access_package_reviewers     = []
      owners                       = ["John.nolan_JusticeUK.onmicrosoft.com#EXT#@TestJusticeUKExternal.onmicrosoft.com", "John.Nolan@TestJusticeUKExternal.onmicrosoft.com"]
      application_contacts = [
        "Eamon.McNally@justice.gov.uk",
        "hibo.abdilaahi@justice.gov.uk",
        "edwin.kruglov@justice.gov.uk",
        "lucas.shaw@justice.gov.uk",
        "tim.peat@justice.gov.uk"
      ]
      allowed_groups = ["APPREG-User-Access-LAAD-Apply-Criminal-Legal-Aid"]
      homepage_url   = "https://staging.apply-for-criminal-legal-aid.service.justice.gov.uk"
      logout_url     = "https://staging.apply-for-criminal-legal-aid.service.justice.gov.uk/providers/logout"
      redirect_uris = [
        "https://laa-apply-for-criminal-legal-aid.test/providers/auth/entra/callback",
        "https://staging.apply-for-criminal-legal-aid.service.justice.gov.uk/providers/auth/entra/callback"
      ]
      mobile_desktop_redirect_uris   = null
      app_roles                      = []
      graph_application_permissions  = []
      graph_delegated_permissions    = ["User.Read"]
      tenants_required               = ["NLEEXTERNAL"]
      access_token_issuance_enabled  = true
      id_token_issuance_enabled      = true
      federated_identity_credentials = []
      service_principle = {
        login_url                     = null
        notification_email_addresses  = []
        preferred_single_sign_on_mode = null
        app_role_assignment_required  = true
        account_enabled               = true
        application_template_name     = null
        hide                          = true
        custom_single_sign_on         = null
      }
      identifier_uris = null
      api = {
        known_client_applications      = null,
        mapped_claims_enabled          = true,
        requested_access_token_version = 2,
        oauth2_permission_scope        = []
      }
    },
    "manage_providers_data" = {
      notes                        = "Application used to manage legal aid provider's data in CWA."
      service_management_reference = "IDAM-2974"
      display_name                 = "Manage a Provider''s Data"
      department_name              = "justice-digital"
      team_name                    = "laa"
      application_name             = "manage-providers-data"
      create_access_package        = false
      access_package_reviewers     = []
      owners                       = ["John.nolan_JusticeUK.onmicrosoft.com#EXT#@TestJusticeUKExternal.onmicrosoft.com", "John.Nolan@TestJusticeUKExternal.onmicrosoft.com"]
      application_contacts = [
        "Eamon.McNally@justice.gov.uk",
        "stephanie.dejong@justice.gov.uk",
        "ben.millar@justice.gov.uk",
        "william.clarke@justice.gov.uk",
        "said.shire@justice.gov.uk",
        "kyle.obrien@justice.gov.uk",
        "javid.ali2@justice.gov.uk"
      ]
      allowed_groups                 = ["APPREG-User-Access-LAAD-Manage-Providers-Data"]
      homepage_url                   = null
      logout_url                     = null
      redirect_uris                  = ["http://localhost:8123/callback"]
      mobile_desktop_redirect_uris   = null
      app_roles                      = []
      graph_application_permissions  = []
      graph_delegated_permissions    = ["User.Read"]
      tenants_required               = ["NLEEXTERNAL"]
      access_token_issuance_enabled  = true
      id_token_issuance_enabled      = true
      federated_identity_credentials = []
      service_principle = {
        login_url                     = null
        notification_email_addresses  = []
        preferred_single_sign_on_mode = null
        app_role_assignment_required  = true
        account_enabled               = true
        application_template_name     = null
        hide                          = true
        custom_single_sign_on         = null
      }
      identifier_uris = null
      api = {
        known_client_applications      = null,
        mapped_claims_enabled          = null,
        requested_access_token_version = null,
        oauth2_permission_scope        = []
      }
    },
    "submit_a_crime_form" = {
      notes                        = "Allowing legal providers to submit applications and claims for CRM4s and CRM7s respectively."
      service_management_reference = "IDAM-2974"
      display_name                 = "Submit A Crime Form"
      department_name              = "justice-digital"
      team_name                    = "laa"
      application_name             = "submit-a-crime-form"
      create_access_package        = false
      access_package_reviewers     = []
      owners                       = ["John.nolan_JusticeUK.onmicrosoft.com#EXT#@TestJusticeUKExternal.onmicrosoft.com", "John.Nolan@TestJusticeUKExternal.onmicrosoft.com"]
      application_contacts = [
        "ellis.kenyo@justice.gov.uk",
        "Ivan.Yohuno@justice.gov.uk",
        "robin.skilling@justice.gov.uk",
        "robin.booth@justice.gov.uk",
        "ewan.wickson@justice.gov.uk",
        "nscc@justice.gov.uk"
      ]
      allowed_groups = ["APPREG-User-Access-LAAD-Submit-Crime-Form"]
      homepage_url   = "https://dev.submit-crime-forms.service.justice.gov.uk/"
      logout_url     = "https://dev.submit-crime-forms.service.justice.gov.uk/providers/logout"
      redirect_uris = [
        "https://dev.submit-crime-forms.service.justice.gov.uk/providers/auth/entra_id/callback"
      ]
      mobile_desktop_redirect_uris   = null
      app_roles                      = []
      graph_application_permissions  = []
      graph_delegated_permissions    = ["User.Read"]
      tenants_required               = ["NLEEXTERNAL"]
      access_token_issuance_enabled  = true
      id_token_issuance_enabled      = true
      federated_identity_credentials = []
      service_principle = {
        login_url                     = null
        notification_email_addresses  = []
        preferred_single_sign_on_mode = null
        app_role_assignment_required  = true
        account_enabled               = true
        application_template_name     = null
        hide                          = true
        custom_single_sign_on         = null
      }
      identifier_uris = null
      api = {
        known_client_applications      = null,
        mapped_claims_enabled          = true,
        requested_access_token_version = 2,
        oauth2_permission_scope        = []
      }
    },
    "laad_lassie_claim_enrichment_api" = {
      notes                        = "Legal Aid Single Sign in Experience API for Claim Enrichment to downstream LAA Services."
      service_management_reference = "IDAM-2974"
      display_name                 = "laad-lassie-claim-enrichment-api"
      department_name              = "justice-digital"
      team_name                    = "laa"
      application_name             = "laad-lassie-claim-enrichment-api"
      create_access_package        = false
      access_package_reviewers     = []
      owners                       = ["John.nolan_JusticeUK.onmicrosoft.com#EXT#@TestJusticeUKExternal.onmicrosoft.com", "John.Nolan@TestJusticeUKExternal.onmicrosoft.com"]
      application_contacts = [
        "Eamon.McNally@justice.gov.uk",
        "Ben.Ashton@justice.gov.uk"
      ]
      allowed_groups                 = []
      homepage_url                   = null
      logout_url                     = null
      redirect_uris                  = []
      mobile_desktop_redirect_uris   = null
      app_roles                      = []
      graph_application_permissions  = ["CustomAuthenticationExtension.Receive.Payload"]
      graph_delegated_permissions    = []
      tenants_required               = ["NLEEXTERNAL"]
      access_token_issuance_enabled  = true
      id_token_issuance_enabled      = true
      federated_identity_credentials = []
      service_principle = {
        login_url                     = null
        notification_email_addresses  = []
        preferred_single_sign_on_mode = null
        app_role_assignment_required  = true
        account_enabled               = true
        application_template_name     = null
        hide                          = true
        custom_single_sign_on         = null
      }
      identifier_uris = ["api://laa-landing-page-test.apps.live.cloud-platform.service.justice.gov.uk/a9faa077-878c-48df-a735-e96ffc694ac5"]
      api = {
        known_client_applications      = null,
        mapped_claims_enabled          = null,
        requested_access_token_version = null,
        oauth2_permission_scope        = []
      }
    },
    "pui" = {
      notes                        = "Client and Cost Management System."
      service_management_reference = "IDAM-3912"
      display_name                 = "PUI (NLE)"
      department_name              = "justice-digital"
      team_name                    = "laa"
      application_name             = "pui"
      create_access_package        = false
      access_package_reviewers     = []
      owners                       = ["Eamon.McNally_justice.gov.uk#EXT#@TestJusticeUKExternal.onmicrosoft.com", "Ben.Ashton_justice.gov.uk#EXT#@TestJusticeUKExternal.onmicrosoft.com"]
      application_contacts = [
        "Eamon.McNally@justice.gov.uk",
        "Ben.Ashton@justice.gov.uk",
        "harry.henry@justice.gov.uk"
      ]
      allowed_groups               = []
      homepage_url                 = "https://account.activedirectory.windowsazure.com:444/applications/default.aspx?metadata=customappsso|ISV9.1|primary|z"
      logout_url                   = null
      redirect_uris                = ["https://idam-provider-ui-laa-ccms-test.apps.live.cloud-platform.service.justice.gov.uk/civil", "https://test-provider-ui-laa-ccms-test.apps.live.cloud-platform.service.justice.gov.uk/civil"]
      mobile_desktop_redirect_uris = null
      app_roles = [
        {
          allowed_member_types  = ["User"]
          description           = "User"
          display_name          = "User"
          id                    = "18d14569-c3bd-439b-9a66-3a2aee01d14f"
          value                 = null
          access_package_hidden = true
        },
        {
          allowed_member_types  = ["User"]
          description           = "msiam_access"
          display_name          = "msiam_access"
          id                    = "b9632174-c057-4f7e-951b-be3adc52bfe6"
          value                 = null
          access_package_hidden = true
        }
      ]
      graph_application_permissions  = []
      graph_delegated_permissions    = []
      tenants_required               = ["NLEEXTERNAL"]
      access_token_issuance_enabled  = false
      id_token_issuance_enabled      = true
      federated_identity_credentials = []
      service_principle = {
        login_url                     = null
        notification_email_addresses  = ["eamon-mcnally-admin@TestJusticeUKExternal.onmicrosoft.com"]
        preferred_single_sign_on_mode = null
        app_role_assignment_required  = true
        account_enabled               = true
        application_template_name     = null
        hide                          = true
        custom_single_sign_on         = true
      }
      identifier_uris = ["PUI-Dev"]
      api = {
        known_client_applications      = []
        mapped_claims_enabled          = true
        requested_access_token_version = 2
        oauth2_permission_scope = [{
          admin_consent_description  = "Access PUI (NLE)"
          admin_consent_display_name = "Access PUI"
          enabled                    = true
          id                         = "214e223c-3269-4f48-8298-b052acbd6860"
          type                       = "User"
          user_consent_description   = "Allow the application to access PUI (NLE) on your behalf."
          user_consent_display_name  = "Access PUI (NLE)"
          value                      = "user_impersonation"
        }]
      }
    }
  }
}
