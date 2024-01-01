# Find the latest available AMI that is tagged with Component = ubuntu
# to see all details of amiId
# aws ec2 describe-images --region <eu-west-2> --image-ids <imageId from cattlog>

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  owners= ["099720109477"]
}

output "data_Persist" {
  value = data.aws_ami.ubuntu.id
}

resource "aws_instance" "data_instanceEC2" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.medium"
  key_name = "jan"
}