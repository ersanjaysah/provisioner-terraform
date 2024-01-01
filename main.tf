resource "aws_instance" "myec2" {
  ami             = "ami-0e5f882be1900e43b"
  instance_type   = "t2.micro"
  key_name        = "jan"
  security_groups = [ aws_security_group.nginx_SG.name ]

  provisioner "local-exec" {
    command = "echo ssh -i jan ubuntu@${aws_instance.myec2.public_ip} >> login.txt"
    
  }

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = "${file("jan")}"
    host = self.public_ip
  }

  provisioner "file" {
    source = "login.txt"
    destination = "/home/ubuntu/login.txt"
  }

  provisioner "remote-exec" {
    inline = [  
      "sudo apt update -y",
      "sudo apt install nginx -y",
      "sudo systemctl start nginx"
    ]
  }
}

output "ec2publicip" {
  value = aws_instance.myec2.public_ip
}