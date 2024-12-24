variable "rm_subscription_id" {
  type        = string
  description = "Azure Subscription ID."
}

variable "rm_tenant_id" {
  type        = string
  description = "Azure Tenant ID."
}

variable "rm_client_id" {
  type        = string
  description = "Client ID for authentication."
}

variable "rm_client_secret" {
  type        = string
  description = "Client Secret for authentication."
}

variable "tenant_id" {
  type        = string
  description = "Azure Tenant ID."
}

variable "client_id" {
  type        = string
  description = "Client ID for authentication."
}

variable "client_secret" {
  type        = string
  description = "Client Secret for authentication."
}

variable "location" {
  type        = string
  default     = "uksouth"
  description = "Azure region for resources to be deployed to."
}

variable "department" {
  type        = string
  default     = "eucs"
  description = "Department name."
}

variable "team" {
  type        = string
  default     = "idam"
  description = "Team Name."
}

variable "state_storage_account_name" {
  type        = string
  default     = "stidamappregtfstate"
  description = "Storage account name for TF state file."
}
