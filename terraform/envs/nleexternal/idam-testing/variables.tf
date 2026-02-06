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
    logo_image                    = string
    display_name                  = string
    department_name               = string
    team_name                     = string
    application_name              = string
    owners                        = list(string)
    application_contacts          = list(string)
    allowed_groups                = list(string)
    homepage_url                  = string
    logout_url                    = string
    redirect_uris                 = list(string)
    access_token_issuance_enabled = bool
    id_token_issuance_enabled     = bool
    mobile_desktop_redirect_uris  = list(string)
    tags                          = list(string)
    app_roles = list(object({
      allowed_member_types = list(string)
      description          = string
      display_name         = string
      id                   = string
      value                = string
    }))
    resource_access               = list(string)
    graph_application_permissions = list(string)
    graph_delegated_permissions   = list(string)
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
}
