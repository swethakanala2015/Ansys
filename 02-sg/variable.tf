variable "project_name" {
  description = "The project name for tagging resources"
  type        = string
  default     = "example-project"
}

variable "environment" {
  description = "The environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "sg_name" {
  description = "The name for the security group"
  type        = string
  default     = "default-sg"
}

variable "allow_ssh" {
  description = "Allow SSH (port 22) traffic (true/false)"
  type        = bool
  default     = true
}