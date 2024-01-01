variable "ports" {
  type = list(number)
  default = [ 22, 80, 443 ]
}

resource "aws_security_group" "nginx_SG" {
  name        = "nginx-SG"
  description = "this sg of nginx by tf"

dynamic "ingress" {
  for_each = var.ports
  content {
    description = "inbound rule"
    from_port = ingress.value
    to_port = ingress.value
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-looping"
  }
}








