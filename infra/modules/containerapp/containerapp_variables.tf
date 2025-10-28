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

variable "container_image" {
  description = "The container image to deploy (e.g., 'mcr.microsoft.com/azuredocs/containerapps-helloworld:latest')"
  type        = string
}

variable "container_port" {
  description = "The port the container listens on"
  type        = number
  default     = 8000
}

variable "container_cpu" {
  description = "The number of CPU cores allocated to the container (e.g., 0.25, 0.5, 1.0)"
  type        = number
  default     = 0.5
}

variable "container_memory" {
  description = "The amount of memory allocated to the container (e.g., '0.5Gi', '1Gi')"
  type        = string
  default     = "1Gi"
}

variable "min_replicas" {
  description = "Minimum number of replicas"
  type        = number
  default     = 1
}

variable "max_replicas" {
  description = "Maximum number of replicas"
  type        = number
  default     = 3
}

variable "env_vars" {
  description = "Environment variables for the container app"
  type = list(object({
    name        = string
    value       = optional(string)
    secret_name = optional(string)
  }))
  default = []
}

variable "secrets" {
  description = "Secrets for the container app"
  type = list(object({
    name  = string
    value = string
  }))
  default   = []
  sensitive = true
}

variable "acr_sku" {
  description = "The SKU of the Azure Container Registry"
  type        = string
  default     = "Basic"
}
