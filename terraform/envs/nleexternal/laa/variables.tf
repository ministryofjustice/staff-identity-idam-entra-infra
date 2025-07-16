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
      identifier_uris = null
    }
  }
}
