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

variable "owners" {
  type        = list(string)
  description = "UPNs of owners. Should be a minimum of 2 people."
}

variable "application_id" {
  type = string
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
