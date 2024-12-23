variable "department_name" {
  type = string
}

variable "team_name" {
  type = string
}

variable "application_name" {
  type = string
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
