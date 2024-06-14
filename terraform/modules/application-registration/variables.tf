variable "display_name" {
	type  = string
    description = "Name of your application. This should be lowercase, alphanumeric in the following pattern: <organisation>-<team>-<applicationname>"
}

variable "owners" {
	type  = list
    description = "UUIDs of the Owners. Should be a minimum of 2 people."
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

