variable "prefix" {
  description = "The prefix used for all deployed resources"
  type        = string
  default     = "fastapi-postgres-aca"
}

variable "location" {
  description = "The supported Azure location where the resource deployed"
  type        = string
}

variable "environment_name" {
  description = "The name of the azd environment to be deployed"
  type        = string
}

variable "admin_username" {
  description = "Admin username for PostgreSQL"
  type        = string
  default     = "pgadmin"
}

# ------------------------------------------------------------------------------------------------------
# Container App Variables
# ------------------------------------------------------------------------------------------------------

variable "container_image" {
  description = "The container image to deploy (e.g., Docker Hub or ACR image)"
  type        = string
  default     = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
}

variable "container_port" {
  description = "The port the container listens on"
  type        = number
  default     = 8000
}

variable "container_cpu" {
  description = "The number of CPU cores allocated to the container"
  type        = number
  default     = 0.5
}

variable "container_memory" {
  description = "The amount of memory allocated to the container"
  type        = string
  default     = "1Gi"
}

variable "min_replicas" {
  description = "Minimum number of container replicas"
  type        = number
  default     = 1
}

variable "max_replicas" {
  description = "Maximum number of container replicas"
  type        = number
  default     = 3
}


