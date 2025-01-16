variable "tenant_id" {
  description = "Azure Tenant ID."
  type        = string
}

variable "client_id" {
  description = "Client ID for authentication."
  type        = string
}

variable "client_secret" {
  description = "Client Secret for authentication."
  type        = string
  default     = null
}

variable "location" {
  description = "Azure region for resources to be deployed to."
  type        = string
  default     = "uksouth"
}

variable "department" {
  description = "Department name."
  type        = string
  default     = "eucs"
}

variable "team" {
  description = "Team Name."
  type        = string
  default     = "idam"
}
