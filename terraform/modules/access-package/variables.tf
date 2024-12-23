variable "catalog_display_name" {
  type = string
  validation {
    condition     = length(var.catalog_display_name) > 7 && can(regex("^[a-z\\-]+$", var.catalog_display_name))
    error_message = "Catalog Display Name must be at least 8 characters long, lowercase alpha."
  }
}

variable "catalog_description" {
  type = string
}

variable "access_package_display_name" {
  type = string
  validation {
    condition     = length(var.access_package_display_name) > 7 && can(regex("^[a-z\\-]+$", var.access_package_display_name))
    error_message = "Access Package Display Name must be at least 8 characters long, lowercase alpha."
  }
}

variable "access_package_description" {
  type = string
}

variable "owners" {
  type        = list(string)
  description = "UPNs of owners. Should be a minimum of 2 people."
}

variable "application_id" {
  type = string
}
