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
  type        = string
  description = "Department name such as EUCS, OPG, LAA, etc."
  validation {
    condition     = can(regex("^[a-zA-Z0-9\\-]+$", var.department_name))
    error_message = "Depeartment Name must be, alphanumeric in the following type of pattern: EUCS, Justice-Digital etc."
  }
}

variable "team_name" {
  type        = string
  description = "Team name acronym such as IDAM, MWP, AP, etc."
  validation {
    condition     = can(regex("^[a-zA-Z0-9\\-]+$", var.team_name))
    error_message = "Team Name must be, alphanumeric in the following type of pattern: IDAM, MWP, AP, OPG, LAA, etc."
  }
}

variable "application_name" {
  type        = string
  description = "Application name Application Registration refers to such as ServiceNow, Slack, Ml-Flow, Intranet, etc."
  validation {
    condition     = can(regex("^[a-zA-Z0-9\\-]+$", var.application_name))
    error_message = "Application Name alphanumeric in the following type of pattern: ServiceNow, Slack, Ml-Flow, Intranet, etc."
  }
}

variable "create_access_package" {
  type        = bool
  description = "Create access packages for managing user access to your application. This requires App Roles to be setup."
  default     = false
}

variable "access_package_reviewers" {
  type     = map(list(string))
  nullable = true
  default = {
    devl = []
    nle  = []
    live = []
  }
  description = "UPNs of reviewers. Should be a minimum of 2 people."
}

variable "owners" {
  type        = list(string)
  description = "UPNs of owners. Should be a minimum of 2 people."
}

variable "allowed_groups" {
  default     = []
  type        = list(string)
  description = "(Optional) List of Security Groups to manage access for people to the application."
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
  type        = map(list(string))
  default = {
    devl = []
    nle  = []
    live = []
  }
}

variable "app_roles" {
  default     = null
  description = "App roles are custom roles to assign permissions to users or apps. The application defines and publishes the app roles and interprets them as permissions during authorization."
  type = list(object({
    allowed_member_types  = list(string)
    description           = string
    display_name          = string
    id                    = string
    value                 = string
    access_package_hidden = bool
  }))
}

variable "graph_application_permissions" {
  default     = null
  nullable    = true
  description = "Graph Application Permissions required on the Application such as 'User.Read.All'."
  type        = list(string)
}

variable "graph_delegated_permissions" {
  default     = null
  nullable    = true
  description = "Graph Delegated Permissions required on the Application such as 'User.Read'."
  type        = list(string)
}

variable "tenants_required" {
  default     = ["DEVL"]
  description = "List of tenants the Application should be setup on. Can be DEVL, NLE and LIVE'."
  type        = list(string)

  validation {
    condition     = length(var.tenants_required) > 0
    error_message = "This application requires at least one tenant to release to."
  }
}

variable "federated_identity_credentials" {
  default     = []
  nullable    = true
  description = "Manages a federated identity credential associated with an application within Azure Active Directory."
  type = list(object({
    repo_name      = string
    display_name   = string
    description    = string
    subject_suffix = string
  }))
}

variable "service_principle" {
  default = {
    login_url                     = null,
    notification_email_addresses  = [],
    preferred_single_sign_on_mode = null,
    app_role_assignment_required  = true,
    account_enabled               = true,
    application_template_name     = null,
    hide                          = null,
  }
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
}

variable "identifier_uris" {
  nullable    = true
  description = "The globally unique URI used to identify this web API. It is the prefix for scopes and in access tokens, it is the value of the audience claim. Also referred to as an identifier URI."
  type        = map(list(string))
  default = {
    devl = []
    nle  = []
    live = []
  }
}
