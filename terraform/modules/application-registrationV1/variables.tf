variable "notes" {
  description = "Description of the applications purpose and any further information to help identify the use case of the application."
  type        = string
}

variable "service_management_reference" {
  description = "Reference to any internal reference number such as Jira ticket number or ServiceNow number."
  type        = string
}

variable "display_name" {
  description = "Friendly display name of the Application."
  type        = string
}

variable "department_name" {
  description = "Department name such as EUCS, OPG, LAA, etc."
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9\\-]+$", var.department_name))
    error_message = "Depeartment Name must be, alphanumeric in the following type of pattern: EUCS, Justice-Digital etc."
  }
}

variable "team_name" {
  description = "Team name acronym such as IDAM, MWP, AP, etc."
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9\\-]+$", var.team_name))
    error_message = "Team Name must be, alphanumeric in the following type of pattern: IDAM, MWP, AP, OPG, LAA, etc."
  }
}

variable "application_name" {
  description = "Application name Application Registration refers to such as ServiceNow, Slack, Ml-Flow, Intranet, etc."
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9\\-]+$", var.application_name))
    error_message = "Application Name alphanumeric in the following type of pattern: ServiceNow, Slack, Ml-Flow, Intranet, etc."
  }
}

variable "create_access_package" {
  description = "Create access packages for managing user access to your application. This requires App Roles to be setup."
  type        = bool
  default     = false
}

variable "access_package_reviewers" {
  description = "UPNs of reviewers. Should be a minimum of 2 people."
  type        = list(string)
  nullable    = true
}

variable "owners" {
  description = "UPNs of owners. Should be a minimum of 2 people."
  type        = list(string)
}

variable "allowed_groups" {
  description = "(Optional) List of Security Groups to manage access for people to the application."
  type        = list(string)
  default     = []
}

variable "homepage_url" {
  description = "The URL to this application's home page or the URL where users can sign-in and use this application."
  type        = string
}

variable "logout_url" {
  description = "Where we send a request to have the application clear the user's session data. This is required for single sign-out to work correctly."
  type        = string
}

variable "redirect_uris" {
  description = "The URIs we will accept as destinations when returning authentication responses (tokens) after successfully authenticating or signing out users. The redirect URI you send in the request to the login server should match one listed here. Also referred to as reply URLs."
  type        = list(string)
}

variable "app_roles" {
  description = "App roles are custom roles to assign permissions to users or apps. The application defines and publishes the app roles and interprets them as permissions during authorization."
  type = list(object({
    allowed_member_types  = list(string)
    description           = string
    display_name          = string
    id                    = string
    value                 = string
    access_package_hidden = bool
  }))
  default = null
}

variable "graph_application_permissions" {
  description = "Graph Application Permissions required on the Application such as 'User.Read.All'."
  type        = list(string)
  nullable    = true
  default     = null
}

variable "graph_delegated_permissions" {
  description = "Graph Delegated Permissions required on the Application such as 'User.Read'."
  type        = list(string)
  nullable    = true
  default     = null
}

variable "tenants_required" {
  description = "List of tenants the Application should be setup on. Can be DEVL, NLE and LIVE'."
  type        = list(string)
  default     = ["DEVL"]

  validation {
    condition     = length(var.tenants_required) > 0
    error_message = "This application requires at least one tenant to release to."
  }
}

variable "federated_identity_credentials" {
  description = "Manages a federated identity credential associated with an application within Azure Active Directory."
  type = list(object({
    repo_name      = string
    display_name   = string
    description    = string
    subject_suffix = string
  }))
  nullable = true
  default  = []
}

variable "service_principle" {
  description = "Service Principle specific properties."
  type = object({
    login_url                     = string
    notification_email_addresses  = list(string)
    preferred_single_sign_on_mode = string
    app_role_assignment_required  = bool
    account_enabled               = bool
    application_template_name     = string
    hide                          = bool
  })
  default = {
    login_url                     = null,
    notification_email_addresses  = [],
    preferred_single_sign_on_mode = null,
    app_role_assignment_required  = true,
    account_enabled               = true,
    application_template_name     = null,
    hide                          = null,
  }
}

variable "identifier_uris" {
  description = "The globally unique URI used to identify this web API. It is the prefix for scopes and in access tokens, it is the value of the audience claim. Also referred to as an identifier URI."
  type        = list(string)
  nullable    = true
}
