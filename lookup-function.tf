variable "ec2-type" {
  type = map 
  default = {
    "dev" = "t2.micro"
    "stage" = "t2.medium"
    "prod" = "t2.large"
  }
}

resource "aws_instance" "myEc2" {
  ami             = "ami-0e5f882be1900e43b"
  instance_type   = lookup(var.ec2-type, terraform.workspace, "t2.nano")
  key_name        = "jan"
  depends_on = [ aws_security_group.nginx_SG ]
}
