variable "location" {
  description = "Azure region for resources to be deployed to."
  type        = string
  default     = "uksouth"
}

variable "applications" {
  description = "Map of application details"
  type = map(object({
    notes                        = string
    service_management_reference = string
    display_name                 = string
    department_name              = string
    team_name                    = string
    application_name             = string
    create_access_package        = bool
    access_package_reviewers     = list(string)
    owners                       = list(string)
    application_contacts         = list(string)
    allowed_groups               = list(string)
    homepage_url                 = string
    logout_url                   = string
    redirect_uris                = list(string)
    mobile_desktop_redirect_uris = list(string)
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
    })
    identifier_uris = list(string)
    api = object({
      known_client_applications      = list(string)
      mapped_claims_enabled          = bool
      requested_access_token_version = string
      oauth2_permission_scope        = list(object({      
        admin_consent_description  = string
        admin_consent_display_name = string
        enabled                    = bool
        id                         = string
        type                       = string
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
      application_contacts           = ["john.nolan@justice.gov.uk","Ben.Ashton@justice.gov.uk","Eamon.McNally@justice.gov.uk"]
      allowed_groups                 = ["APPREG-User-Access-LAAD-LASSIE","DEPT-All-Legal-Aid-Agency-Internal-Staff"]
      homepage_url                   = null
      logout_url                     = null
      redirect_uris                  = ["https://laa-landing-page-dev.apps.live.cloud-platform.service.justice.gov.uk/login/oauth2/code/azure"]
      mobile_desktop_redirect_uris   = null
      app_roles                      = []
      graph_application_permissions  = ["CustomAuthenticationExtension.Receive.Payload","User.Invite.All","Directory.Read.All","User.Read.All","GroupMember.ReadWrite.All","AuditLog.Read.All","Application.Read.All"]
      graph_delegated_permissions    = ["User.Read","User.RevokeSessions.All"]
      tenants_required               = ["NLEEXTERNAL"]
      federated_identity_credentials = []
      service_principle = {
        login_url                     = null
        notification_email_addresses  = []
        preferred_single_sign_on_mode = null
        app_role_assignment_required  = true
        account_enabled               = true
        application_template_name     = null
        hide                          = null
      }
      identifier_uris = ["api://laa-landing-page-dev.apps.live.cloud-platform.service.justice.gov.uk/77595545-15fc-4d83-89d4-3e36387dafa9"]
      api = {
        known_client_applications      = []
        mapped_claims_enabled          = false
        requested_access_token_version = 1
        oauth2_permission_scope = [{
          admin_consent_description  = "Allows the application to access the API on behalf of the signed-in user"
          admin_consent_display_name = "Access Claim Enrichment"
          enabled                    = true
          id                         = "5eff006b-3ee5-4038-a473-2fbc1443291a"
          type                       = "Admin"
          value                      = "user_impersonation"
        }]
      }
    },
    "apply_civil_legal_aid" = {
      notes                          = "Enables providers to submit an application for civil legal aid."
      service_management_reference   = "IDAM-2974"
      display_name                   = "Apply for Civil Legal Aid"
      department_name                = "justice-digital"
      team_name                      = "laa"
      application_name               = "apply-for-civil-legal-aid"
      create_access_package          = false
      access_package_reviewers       = []
      owners                         = ["John.nolan_JusticeUK.onmicrosoft.com#EXT#@TestJusticeUKExternal.onmicrosoft.com", "John.Nolan@TestJusticeUKExternal.onmicrosoft.com"]
      application_contacts           = [
        "Ben.Ashton@justice.gov.uk",
        "Eamon.McNally@justice.gov.uk",
        "joel.sugarman@justice.gov.uk",
        "colin.bruce1@justice.gov.uk",
        "adam.goldstone@justice.gov.uk",
        "stephanie.dejong@justice.gov.uk"
      ]
      allowed_groups                 = ["APPREG-User-Access-LAAD-Apply-Civil-Legal-Aid"]
      homepage_url                   = "https://main-applyforlegalaid-uat.cloud-platform.service.justice.gov.uk/"
      logout_url                     = null
      redirect_uris                  = [
        "https://main-applyforlegalaid-uat.cloud-platform.service.justice.gov.uk/auth/entra_id/callback",
        "https://staging.apply-for-legal-aid.service.justice.gov.uk/auth/entra_id/callback",
        "https://localhost:3000/providers/auth/entra_id/callback",
        "https://main-applyforlegalaid-uat.cloud-platform.service.justice.gov.uk/auth/azure_ad/callback",
        "https://staging.apply-for-legal-aid.service.justice.gov.uk/auth/azure_ad/callback",
        "https://localhost:3000/providers/auth/azure_ad/callback"
      ]
      mobile_desktop_redirect_uris   = null
      app_roles                      = []
      graph_application_permissions  = []
      graph_delegated_permissions    = ["User.Read"]
      tenants_required               = ["NLEEXTERNAL"]
      federated_identity_credentials = []
      service_principle = {
        login_url                     = null
        notification_email_addresses  = []
        preferred_single_sign_on_mode = null
        app_role_assignment_required  = true
        account_enabled               = true
        application_template_name     = null
        hide                          = null
      }
      identifier_uris = null
      api             = null
    },
    "apply_criminal_legal_aid" = {
      notes                          = "Apply for criminal legal aid is a service enabling providers to apply for criminal legal aid online. It is used by provider firms to submit applications on behalf of their clients, to make changes to returned applications, to provide additional evidence or to make supplementary applications when a client's circumstance change."
      service_management_reference   = "IDAM-2974"
      display_name                   = "Apply for Criminal Legal Aid"
      department_name                = "justice-digital"
      team_name                      = "laa"
      application_name               = "apply-for-criminal-legal-aid"
      create_access_package          = false
      access_package_reviewers       = []
      owners                         = ["John.nolan_JusticeUK.onmicrosoft.com#EXT#@TestJusticeUKExternal.onmicrosoft.com", "John.Nolan@TestJusticeUKExternal.onmicrosoft.com"]
      application_contacts           = [
        "Eamon.McNally@justice.gov.uk",
        "hibo.abdilaahi@justice.gov.uk",
        "edwin.kruglov@justice.gov.uk",
        "lucas.shaw@justice.gov.uk",
        "tim.peat@justice.gov.uk"
      ]
      allowed_groups                 = ["APPREG-User-Access-LAAD-Apply-Criminal-Legal-Aid"]
      homepage_url                   = "https://staging.apply-for-criminal-legal-aid.service.justice.gov.uk"
      logout_url                     = null
      redirect_uris                  = [
        "http://localhost:3000/providers/auth/entra/callback",
        "https://laa-apply-for-criminal-legal-aid.test/providers/auth/entra/callback",
        "https://localhost:3000/providers/auth/entra/callback",
        "https://staging.apply-for-criminal-legal-aid.service.justice.gov.uk/providers/auth/entra/callback"
      ]
      mobile_desktop_redirect_uris   = null
      app_roles                      = []
      graph_application_permissions  = []
      graph_delegated_permissions    = ["User.Read"]
      tenants_required               = ["NLEEXTERNAL"]
      federated_identity_credentials = []
      service_principle = {
        login_url                     = null
        notification_email_addresses  = []
        preferred_single_sign_on_mode = null
        app_role_assignment_required  = true
        account_enabled               = true
        application_template_name     = null
        hide                          = null
      }
      identifier_uris = null
      api             = null
    },
    "manage_providers_data" = {
      notes                          = "Application used to manage legal aid provider's data in CWA."
      service_management_reference   = "IDAM-2974"
      display_name                   = "Manage a Provider''s Data"
      department_name                = "justice-digital"
      team_name                      = "laa"
      application_name               = "manage-providers-data"
      create_access_package          = false
      access_package_reviewers       = []
      owners                         = ["John.nolan_JusticeUK.onmicrosoft.com#EXT#@TestJusticeUKExternal.onmicrosoft.com", "John.Nolan@TestJusticeUKExternal.onmicrosoft.com"]
      application_contacts           = [
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
      federated_identity_credentials = []
      service_principle = {
        login_url                     = null
        notification_email_addresses  = []
        preferred_single_sign_on_mode = null
        app_role_assignment_required  = true
        account_enabled               = true
        application_template_name     = null
        hide                          = null
      }
      identifier_uris = null
      api             = null
    },
    "submit_a_crime_form" = {
      notes                          = "Allowing legal providers to submit applications and claims for CRM4s and CRM7s respectively."
      service_management_reference   = "IDAM-2974"
      display_name                   = "Submit A Crime Form"
      department_name                = "justice-digital"
      team_name                      = "laa"
      application_name               = "submit-a-crime-form"
      create_access_package          = false
      access_package_reviewers       = []
      owners                         = ["John.nolan_JusticeUK.onmicrosoft.com#EXT#@TestJusticeUKExternal.onmicrosoft.com", "John.Nolan@TestJusticeUKExternal.onmicrosoft.com"]
      application_contacts           = [
        "ellis.kenyo@justice.gov.uk",
        "Ivan.Yohuno@justice.gov.uk",
        "robin.skilling@justice.gov.uk",
        "robin.booth@justice.gov.uk",
        "ewan.wickson@justice.gov.uk",
        "nscc@justice.gov.uk"
      ]
      allowed_groups                 = ["APPREG-User-Access-LAAD-Submit-Crime-Form"]
      homepage_url                   = null
      logout_url                     = null
      redirect_uris                  = [
        "https://crm457-2661-testin-nscc-provider-dev.cloud-platform.service.justice.gov.uk/providers/auth/entra_id/callback",
        "https://nsm-submit.test/providers/auth/entra_id/callback"
      ]
      mobile_desktop_redirect_uris   = null
      app_roles                      = []
      graph_application_permissions  = []
      graph_delegated_permissions    = ["User.Read"]
      tenants_required               = ["NLEEXTERNAL"]
      federated_identity_credentials = []
      service_principle = {
        login_url                     = null
        notification_email_addresses  = []
        preferred_single_sign_on_mode = null
        app_role_assignment_required  = true
        account_enabled               = true
        application_template_name     = null
        hide                          = null
      }
      identifier_uris = null
      api             = null
    },
    "laad_lassie_claim_enrichment_api" = {
      notes                          = "Legal Aid Single Sign in Experience API for Claim Enrichment to downstream LAA Services."
      service_management_reference   = "IDAM-2974"
      display_name                   = "laad-lassie-claim-enrichment-api"
      department_name                = "justice-digital"
      team_name                      = "laa"
      application_name               = "laad-lassie-claim-enrichment-api"
      create_access_package          = false
      access_package_reviewers       = []
      owners                         = ["John.nolan_JusticeUK.onmicrosoft.com#EXT#@TestJusticeUKExternal.onmicrosoft.com", "John.Nolan@TestJusticeUKExternal.onmicrosoft.com"]
      application_contacts           = [
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
      federated_identity_credentials = []
      service_principle = {
        login_url                     = null
        notification_email_addresses  = []
        preferred_single_sign_on_mode = null
        app_role_assignment_required  = true
        account_enabled               = true
        application_template_name     = null
        hide                          = null
      }
      identifier_uris = ["api://laa-landing-page-dev.apps.live.cloud-platform.service.justice.gov.uk/a9faa077-878c-48df-a735-e96ffc694ac5"]
      api             = null
    },
    "pui" = {
      notes                          = "Client and Cost Management System."
      service_management_reference   = "IDAM-2974"
      display_name                   = "PUI"
      department_name                = "justice-digital"
      team_name                      = "laa"
      application_name               = "pui"
      create_access_package          = false
      access_package_reviewers       = []
      owners                         = ["John.nolan_JusticeUK.onmicrosoft.com#EXT#@TestJusticeUKExternal.onmicrosoft.com", "John.Nolan@TestJusticeUKExternal.onmicrosoft.com"]
      application_contacts           = [
        "Eamon.McNally@justice.gov.uk",
        "Ben.Ashton@justice.gov.uk",
        "harry.henry@justice.gov.uk"
      ]
      allowed_groups                 = ["APPREG-User-Access-LAAD-PUI"]
      homepage_url                   = "https://account.activedirectory.windowsazure.com:444/applications/default.aspx?metadata=customappsso|ISV9.1|primary|z"
      logout_url                     = null
      redirect_uris                  = ["http://localhost:8080/civil/login/saml2/sso","https://idam-provider-ui-laa-ccms-dev.apps.live.cloud-platform.service.justice.gov.uk/civil/login/saml2/sso"]
      mobile_desktop_redirect_uris   = null
      app_roles                      = []
      graph_application_permissions  = []
      graph_delegated_permissions    = []
      tenants_required               = ["NLEEXTERNAL"]
      federated_identity_credentials = []
      service_principle = {
        login_url                     = null
        notification_email_addresses  = []
        preferred_single_sign_on_mode = null
        app_role_assignment_required  = true
        account_enabled               = true
        application_template_name     = null
        hide                          = null
      }
      identifier_uris = ["api://594f6a8d-0914-41ce-9687-f1cbfffb0ece"]
      api             = null
    }
  }
}
