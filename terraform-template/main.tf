locals {
  tags = {
    department = ""
    team       = ""
    source     = "terraform"
  }
}

#region Application Registrations
module "application-registration" {
  source                         = "../../../modules/application-registrationV1.8.2"
  for_each                       = local.applications
  notes                          = each.value.notes
  logo_image                     = each.value.logo_image
  service_management_reference   = each.value.service_management_reference
  display_name                   = each.value.display_name
  department_name                = each.value.department_name
  team_name                      = each.value.team_name
  owners                         = each.value.owners
  application_contacts           = each.value.application_contacts
  allowed_groups                 = each.value.allowed_groups
  homepage_url                   = each.value.homepage_url
  logout_url                     = each.value.logout_url
  redirect_uris                  = each.value.redirect_uris
  mobile_desktop_redirect_uris   = each.value.mobile_desktop_redirect_uris
  app_roles                      = each.value.app_roles
  graph_application_permissions  = each.value.graph_application_permissions
  graph_delegated_permissions    = each.value.graph_delegated_permissions
  access_token_issuance_enabled  = each.value.access_token_issuance_enabled
  id_token_issuance_enabled      = each.value.id_token_issuance_enabled
  federated_identity_credentials = each.value.federated_identity_credentials
  service_principle              = each.value.service_principle
  identifier_uris                = each.value.identifier_uris
  api                            = each.value.api
  tags                           = each.value.tags
  resource_access                = each.value.custom_application_permissions
}
#endregion

locals {
  applications = {
    "default_app" = {
      notes                          = "" # Notes about the application
      logo_image                     = "./assets/MOJ_Lesser_Arms_Stacked_HEX_215x215.jpg" # Path to application logo image
      service_management_reference   = "" # Reference to link application to service management tool (e.g. Jira ticket number)
      display_name                   = "" # Name of the application as it will appear in Entra and to customers using SSO
      department_name                = "" # Name of the department the application belongs to, used for tagging and access management purposes
      team_name                      = "" # Name of the team that owns the application, used for tagging and access management purposes
      owners                         = [] # List of application owners for the application in Entra ID
      application_contacts           = [] # List of contacts for the application, used for notifications about expiring secrets and other application-related events
      allowed_groups                 = [] # List of groups that are allowed to sign in to the application, used for access management purposes
      homepage_url                   = null # URL of the application's homepage
      logout_url                     = null # URL to redirect users to after they sign out of the application
      redirect_uris                  = null # List of URIs to redirect to after signing in, used for web applications
      mobile_desktop_redirect_uris   = null # List of URIs to redirect to after signing in, used for mobile and desktop applications
      app_roles                      = [] # List of roles for the application, used for access management purposes
      graph_application_permissions  = [] # List of Graph API application permissions for the application
      graph_delegated_permissions    = [] # List of Graph API delegated permissions for the application
      access_token_issuance_enabled  = false # Whether the application should issue access tokens, used for API applications
      id_token_issuance_enabled      = false # Whether the application should issue ID tokens, used for applications that require user authentication
      federated_identity_credentials = [] # List of federated identity credentials for the application, used for passwordless authentication      
      service_principle = {
        login_url                     = null # URL to redirect users to for login
        notification_email_addresses  = [] # List of email addresses to notify about application-related events
        preferred_single_sign_on_mode = null # Preferred single sign-on mode for the service principal (e.g. "SAML", "Password", "Federated")
        app_role_assignment_required  = false # Whether the service principal requires app role assignment for users
        account_enabled               = true # Whether the service principal account is enabled
        application_template_name     = null # Name of an application template to use for the service principal, if any
        hide                          = true # Whether to hide the application from the application gallery in Entra
        custom_single_sign_on         = null # Custom single sign-on configuration for the service principal, if required
      }
      identifier_uris = null # List of identifier URIs for the application, used for API applications
      api = {
        known_client_applications      = [], # List of known client applications that will be calling the API, used for API applications
        mapped_claims_enabled          = false, # Whether to enable mapped claims for the API, used for API applications
        requested_access_token_version = null, # Requested access token version for the API (e.g. 1 or 2), used for API applications
        oauth2_permission_scope = [] # List of OAuth2 permission scopes for the API, used for API applications
      }
      tags = ["Business unit: EUCS", "authPattern: ClientCredentials", "project: ExampleName"] # List of tags to apply to the application for organizational and access management purposes
      custom_application_permissions = [] # List of custom application permissions for the application, used for API applications
    }
  }
}
