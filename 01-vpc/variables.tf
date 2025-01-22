variable "environment" {
  description = "The environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "The project name for tagging resources"
  type        = string
  default     = "example-project"
}