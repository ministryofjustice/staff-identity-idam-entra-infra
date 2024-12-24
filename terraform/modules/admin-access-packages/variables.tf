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

variable "role_name" {
  type        = string
  description = "The Role of the teams Access Package such as Security, Engineers, etc."
  validation {
    condition     = can(regex("^[a-zA-Z\\-]+$", var.role_name))
    error_message = "Role must be, alpha in the following type of pattern: Security, Engineers, etc."
  }
}

variable "catalogue_id" {
  type = string
}

variable "roles" {
  type        = list(string)
  description = "List of Built-in Entra Roles to give Eligible permissions such as Security Reader, Reports Reader, User Administrator, etc."
}
