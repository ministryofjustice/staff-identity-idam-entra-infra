variable "location" {
  description = "Azure region for resources to be deployed to."
  type        = string
  default     = "uksouth"
}

variable "client_id" {
  description = "Azure app reg client id"
  type        = string
}

variable "tenant_id" {
  description = "Azure tenant id"
  type        = string
}
