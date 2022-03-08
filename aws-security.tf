#################################  security group  #######################################################
resource "aws_security_group" "terraform-sg-smit" {
  name        = "terraform-sg-smit"
  description = "Allow tcs all trafiic allow"

  dynamic "ingress" {
    for_each = var.ports
    iterator = port
    content {
      description = "TLS from VPC"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}

# output awssecuritygroupDetails {
#   value = "${aws_security_group.terraform-sg-smit.id}" //keypair name
# }

