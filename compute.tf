resource "aws_instance" "instance_1" {
  ami             = "ami-011899242bb902164" # Ubuntu 20.04 LTS // us-east-1
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.public_1.id
  security_groups = [aws_security_group.instances_1_security.id]
  key_name = "aws-key"
  tags = {
    Name = "Nginx_server"
  }
  provisioner "remote-exec" {
    inline = [ "echo 'Wait until SSH is ready'" ]
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("/home/ubuntu-root/Downloads/keys/aws-key")
      host = self.public_ip
    }
  }
  provisioner "local-exec" {
    command = "ansible-playbook -i ${aws_instance.instance_1.public_ip}, --private-key /home/ubuntu-root/Downloads/keys/aws-key install_nginx.yml"
  }
  provisioner "local-exec" {
    command = "echo ${self.public_ip} > instance_ip.txt"
  }
}