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
    "diso_teams_routing" = {
      notes                          = "We need ReadWrite access as we need to read business excel files for one requirement
and also use this site to mirror/write s3 table data and which we use to be read by power BI apps"
      service_management_reference   = "IDAM-4459"
      display_name                   = "MoJO-DEDSAI-DMET-MDS"
      department_name                = "DEDSAI"
      team_name                      = "DMET"
      application_name               = "MoJO-DEDSAI-DMET-MDS"
      create_access_package          = false
      access_package_reviewers       = []
      owners                         = ["Shanmugapriya.Basker@justice.gov.uk"]
      allowed_groups                 = []
      homepage_url                   = null
      logout_url                     = null
      redirect_uris                  = null
      mobile_desktop_redirect_uris   = ["http://localhost/"]
      app_roles                      = []
      graph_application_permissions  = ["sites.selected"]
      graph_delegated_permissions    = ["sites.selected"]
      tenants_required               = ["LIVE"]
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
