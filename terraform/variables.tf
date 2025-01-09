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

variable "state_tenant_id" {
  type        = string
  description = "TF State Azure Tenant ID."
}

variable "state_client_id" {
  type        = string
  description = "TF State Client ID for authentication."
}

variable "state_subscription_id" {
  type        = string
  description = "TF State Subscription ID for authentication."
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
