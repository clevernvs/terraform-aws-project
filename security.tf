resource "aws_security_group" "devopspro_lab_sg_web" {
  name        = "devopspro-lab-sg-web"
  description = "Regras de firewall para as EC2 para aplicacao Web"
  vpc_id      = aws_vpc.devopspro_lab_vpc.id

  ingress {
    description      = "Acesso HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "Acesso HTTPs"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "Acesso SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "Acesso HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "Acesso HTTPs"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "Acesso DNS"
    from_port        = 53
    to_port          = 53
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "Acesso DNS"
    from_port        = 53
    to_port          = 53
    protocol         = "udp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "Acesso SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "Acesso MongoDB"
    from_port        = 27017
    to_port          = 27017
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "devopspro-lab-sg-web"
  }
}

resource "aws_network_acl" "devopspro_lab_network_acl_public" {
  vpc_id     = aws_vpc.devopspro_lab_vpc.id
  subnet_ids = [aws_subnet.devopspro_lab_subnet_public.id]

  # Portas HTTP
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0./0"
    from_port  = 80
    to_port    = 80
  }

  # Portas HTTPs
  ingress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0./0"
    from_port  = 443
    to_port    = 443
  }

  # Portas SSH
  ingress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0./0"
    from_port  = 22
    to_port    = 22
  }

  # Portas Efemeras
  ingress {
    protocol   = "tcp"
    rule_no    = 130
    action     = "allow"
    cidr_block = "0.0.0./0"
    from_port  = 1024
    to_port    = 65535
  }

  # Portas DNS (tcp)
  ingress {
    protocol   = "tcp"
    rule_no    = 140
    action     = "allow"
    cidr_block = "0.0.0./0"
    from_port  = 53
    to_port    = 53
  }

  # Portas DNS (udp)
  ingress {
    protocol   = "udp"
    rule_no    = 150
    action     = "allow"
    cidr_block = "0.0.0./0"
    from_port  = 53
    to_port    = 53
  }

  # Portas Efemeras
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0./0"
    from_port  = 1024
    to_port    = 65535
  }

  # Portas HTTP
  egress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0./0"
    from_port  = 80
    to_port    = 80
  }

  # Portas HTTPs
  egress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0./0"
    from_port  = 443
    to_port    = 443
  }

  # Portas DNS
  egress {
    protocol   = "tcp"
    rule_no    = 130
    action     = "allow"
    cidr_block = "0.0.0./0"
    from_port  = 53
    to_port    = 53
  }

  # Portas DNS
  egress {
    protocol   = "udp"
    rule_no    = 140
    action     = "allow"
    cidr_block = "0.0.0./0"
    from_port  = 53
    to_port    = 53
  }

  # Portas SSH
  egress {
    protocol   = "tcp"
    rule_no    = 150
    action     = "allow"
    cidr_block = "0.0.0./0"
    from_port  = 22
    to_port    = 22
  }


  tags = {
    Name = "devopspro-lab-network-acl-public"
  }
}


resource "aws_security_group" "devopspro_lab_sg_db" {
  name        = "devopspro-lab-sg-db"
  description = "Regras de firewall para as EC2 para o Banco de Dados"
  vpc_id      = aws_vpc.devopspro_lab_vpc.id

  ingress {
    description     = "Acesso MongoDB"
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    security_groups = [aws_security_group.devopspro_lab_sg_web.id]
    # cidr_blocks      = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description = "Acesso SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.devopspro_lab_vpc.cidr_block]
  }

  egress {
    description      = "Acesso HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "Acesso HTTPs"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "Acesso DNS"
    from_port        = 53
    to_port          = 53
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "Acesso DNS"
    from_port        = 53
    to_port          = 53
    protocol         = "udp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "devopspro-lab-sg-db"
  }
}
