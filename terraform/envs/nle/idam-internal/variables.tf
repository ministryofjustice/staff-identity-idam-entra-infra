variable "location" {
  description = "Azure region for resources to be deployed to."
  type        = string
  default     = "uksouth"
}

variable "engineer_object_ids" {
  type = map(string)
  default = {
    "jason"   = "369d87ee-ed68-4cf3-8306-a711dd296d5f"
    "luciano" = "0beaf9d2-60d5-44f2-8f20-78ef6cd0341b"
    "mike"    = "d17c5b94-d6b9-4425-bdaa-08a86c9bb9da"
    "abarna"  = "16da44e7-3e25-4cf5-8d6f-2eab69859963"
    "matt"    = "a4c5e28a-4c3b-4600-b827-33ffec9a9121"
    "davidH"  = "ce142434-27d0-4112-89f5-4e768879abde"
    "davidS"  = "1ae3de89-d85f-4fb1-b1d9-36d9c641bf7d"
    "lee"     = "012ccc81-bbfa-4e94-8058-c30e6cfc5643"
    "john"    = "38cc9777-479f-450f-acf8-f8856ba861ba"
  }
}
