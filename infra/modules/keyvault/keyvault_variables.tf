variable "rg_name" {
  description = "The name of the resource group to deploy resources into"
  type        = string
}

variable "location" {
  description = "The supported Azure location where the resource deployed"
  type        = string
}

variable "prefix" {
  description = "The prefix used for all deployed resources"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "secrets" {
  description = "A list of secrets to be added to the keyvault"
  type = list(object({
    name  = string
    value = string
  }))
  sensitive = true
}
