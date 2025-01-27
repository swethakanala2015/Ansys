locals {
  name = "${var.project_name}-${var.environment}-${var.sg_name}"
}

resource "aws_security_group" "default" {
  vpc_id = aws_vpc.main.id


  dynamic "ingress" {
    for_each = var.allow_ssh ? toset(var.ssh_cidr_blocks) : []
    content {
      description = "Allow SSH traffic"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }


  dynamic "ingress" {
    for_each = var.allow_http ? toset(var.http_cidr_blocks) : []
    content {
      description = "Allow HTTP traffic"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.allow_all_egress ? var.egress_cidr_blocks : []
  }

   tags = merge(
    {
      Name = "${var.environment}-${var.project_name}-default-sg"
    },
    var.common_tags
  )
}
