variable "display_name" {
  type        = string
  description = "Name of your application. This should be at least 8 characters long, lowercase, alphanumeric in the following pattern: organisation-team-applicationname"
  validation {
    condition     = length(var.display_name) > 8 && can(regex("^[a-z0-9\\-]+$", var.display_name))
    error_message = "Application Name must be at least 8 characters long, lowercase, alphanumeric in the following pattern: organisation-team-applicationname."
  }
}

variable "notes" {
  description = "Description of the applications purpose and any further information to help identify the use case of the application."
  type        = string
}

variable "service_management_reference" {
  description = "Reference to any internal reference number such as Jira ticket number or ServiceNow number."
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

variable "owners" {
  type        = list(string)
  description = "UPNs of owners. Should be a minimum of 2 people."

  validation {
    condition     = length(var.owners) > 1
    error_message = "This application requires at least two Owners."
  }
}

variable "homepage_url" {
  description = "The URL to this application’s home page or the URL where users can sign-in and use this application."
  type        = string
}

variable "logout_url" {
  description = "This is where we send a request to have the application clear the user's session data. This is required for single sign-out to work correctly."
  type        = string
}

variable "redirect_uris" {
  description = "The URIs we will accept as destinations when returning authentication responses (tokens) after successfully authenticating or signing out users. The redirect URI you send in the request to the login server should match one listed here. Also referred to as reply URLs."
  type        = list(any)
}

variable "app_roles" {
  default     = null
  description = "App roles are custom roles to assign permissions to users or apps. The application defines and publishes the app roles and interprets them as permissions during authorization."
  type = list(object({
    allowed_member_types = list(string)
    description          = string
    display_name         = string
    id                   = string
    value                = string
  }))
}

variable "required_resource_access_roles" {
  default     = []
  description = "Graph Application Permissions required on the Application such as 'User.Read.All'."
  type        = list(string)
}

variable "required_resource_access_scopes" {
  default     = []
  description = "Graph Delegated Permissions required on the Application such as 'User.Read'."
  type        = list(string)
}
