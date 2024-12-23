variable "display_name" {
  type        = string
  description = "Name of your application. This should be at least 8 characters long, lowercase, alphanumeric in the following pattern: organisation-team-applicationname"

  validation {
    condition     = length(var.display_name) > 8 && can(regex("^[a-z0-9\\-]+$", var.display_name))
    error_message = "Application Name must be at least 8 characters long, lowercase, alphanumeric in the following pattern: organisation-team-applicationname."
  }
}

variable "notes" {
  type = string
}

variable "service_management_reference" {
  type = string
}

variable "department_name" {
  type = string
}

variable "team_name" {
  type = string
}

variable "application_name" {
  type = string
}

variable "create_access_package" {
  type    = bool
  default = false
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
  type = string
}

variable "logout_url" {
  type = string
}

variable "redirect_uris" {
  type = list(any)
}

variable "app_roles" {
  default = null
  type = list(object({
    allowed_member_types = list(string)
    description          = string
    display_name         = string
    id                   = string
    value                = string
  }))
}

variable "required_resource_access_roles" {
  default = []
  type    = list(string)
}

variable "required_resource_access_scopes" {
  default = []
  type    = list(string)
}
