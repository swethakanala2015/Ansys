### Locals
locals {
  name = "${var.environment}-${var.project_name}"
}

### VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = merge(
    {
      Name = local.name
    },
    var.common_tags
  )
}