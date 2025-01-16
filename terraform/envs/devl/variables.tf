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
