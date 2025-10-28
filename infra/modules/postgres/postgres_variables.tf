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

variable "admin_username" {
  description = "The admin username of the PostgreSQL server"
  type        = string
}

variable "admin_password" {
  description = "The admin password of the PostgreSQL server"
  type        = string
  sensitive   = true
}

variable "postgres_version" {
  description = "The version of the PostgreSQL server"
  type        = string
  default     = "17"
}

variable "sku_name" {
  description = "The sku name of the PostgreSQL server"
  type        = string
  default     = "B_Standard_B1ms"
}
