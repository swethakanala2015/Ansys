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

variable "ssh_cidr_blocks" {
  description = "CIDR blocks allowed for SSH traffic"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "allow_http" {
  description = "Allow HTTP (port 80) traffic (true/false)"
  type        = bool
  default     = true
}

variable "http_cidr_blocks" {
  description = "CIDR blocks allowed for HTTP traffic"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}


variable "allow_all_egress" {
  description = "Allow all outbound traffic (true/false)"
  type        = bool
  default     = true
}

variable "egress_cidr_blocks" {
  description = "CIDR blocks allowed for outbound traffic"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {
    Owner       = "team"
    Environment = "dev"
    Terraform   = "true"
  }
}