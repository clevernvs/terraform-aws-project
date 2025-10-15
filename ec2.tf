resource "aws_key_pair" "kpair_ssh" {
  key_name   = "devopspro-labs-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "web_ec2" {
  ami                         = "ami-053b0d53c279acc90"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.devopspro_lab_subnet_public.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.devopspro_lab_sg_web.id]
  key_name                    = aws_key_pair.kpair_ssh.key_name
  user_data                   = file("./docker-install.sh")

  tags = {
    Name = "web-ec2"
  }
}

resource "aws_instance" "db_ec2" {
  ami                    = "ami-053b0d53c279acc90"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.devopspro_lab_subnet_private.id
  vpc_security_group_ids = [aws_security_group.devopspro_lab_sg_db.id]
  key_name               = aws_key_pair.kpair_ssh.key_name
  user_data              = file("./docker-install.sh")

  tags = {
    Name = "db-ec2"
  }
}

output "web_ip" {
  value = aws_instance.web_ec2.public_ip
}

output "db_ip" {
  value = aws_instance.db_ec2.private_ip
}
