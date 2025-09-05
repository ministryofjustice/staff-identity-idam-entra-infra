variable "location" {
  description = "Azure region for resources to be deployed to."
  type        = string
  default     = "uksouth"
}

variable "engineer_object_ids" {
  type = map(string)
  default = {
    "jason"   = "d1ed6381-bd89-4d61-a1f5-95ccc3d61366"
    "luciano" = "d904ed25-013f-4865-90d4-768705fa4b55"
    "mike"    = "9d7b8242-c676-4bbc-b1e9-8d80e5d0c695"
    "abarna"  = "b047df82-70b5-413b-9a9a-6c124069d525"
    "matt"    = "dea4036e-fe8b-448a-aad9-f62f68aa5d6d"
    "davidH"  = "c41bb844-1b70-4054-90a4-022f4394adcd"
    "davidS"  = "edbbf78a-743a-4882-b936-44db72748efd"
    "lee"     = "18b2af17-0361-436d-a908-15fc731eef8f"
    "john"    = "13c1e9d4-6f71-4015-b8b8-fa20ca4545d8"
  }
}
