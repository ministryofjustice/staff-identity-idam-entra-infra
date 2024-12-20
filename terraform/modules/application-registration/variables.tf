variable "display_name" {
	type  = string
    description = "Name of your application. This should be at least 8 characters long, lowercase, alphanumeric in the following pattern: organisation-team-applicationname"

    validation {
        condition     = length(var.display_name) > 8 && can(regex("^[a-z0-9\\-]+$", var.display_name))
        error_message = "Application Name must be at least 8 characters long, lowercase, alphanumeric in the following pattern: organisation-team-applicationname."
    }
}

variable "owners" {
	type  = list
    description = "UPNs of owners. Should be a minimum of 2 people."

    validation {
        condition     = length(var.owners) > 1
        error_message = "This application requires at least two Owners."
    }
}

variable "homepage_url" {
	type  = string
}

variable "logout_url" {
	type  = string
}

variable "redirect_uris" {
	type  = list
}

variable "group_membership_claims" {
	type  = list
    description = "Optionally send the users group memberships with the claim. Options are None, SecurityGroup, DirectoryRole, ApplicationGroup or All"
}

