variable "display_name" {
  description = "The name of the Azure AD Application."
  type        = string
}

variable "identifier_uris" {
  description = "The identifier URI's."
  type        = list(string)
}

variable "owners" {
  description = "A list of owners for the Azure AD Enterprise Application."
  type        = list(string)
}

variable "sso_mode" {
  description = "The required mode for SSO I.E SAML."
  type        = string
}

