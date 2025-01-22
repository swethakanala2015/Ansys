resource "aws_security_group" "default" {
  vpc_id = aws_vpc.main.id

  # Conditional Ingress Rules for SSH
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