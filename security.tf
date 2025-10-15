resource "aws_security_group" "devopspro_lab_sg_web" {
  name        = var.security_group_web_name
  description = "Regras de firewall para as EC2 para aplicacao Web"
  vpc_id      = aws_vpc.devopspro_lab_vpc.id

  dynamic "ingress" {
    for_each = var.security_group_web_ingresses
    content {
      description      = ingress.value["description"]
      from_port        = ingress.value["from_port"]
      to_port          = ingress.value["to_port"]
      protocol         = ingress.value["protocol"]
      cidr_blocks      = ingress.value["cidr_blocks"]
      ipv6_cidr_blocks = ingress.value["ipv6_cidr_blocks"]

    }
  }

  dynamic "egress" {
    for_each = var.security_group_web_egresses
    content {
      description      = egress.value["description"]
      from_port        = egress.value["from_port"]
      to_port          = egress.value["to_port"]
      protocol         = egress.value["protocol"]
      cidr_blocks      = egress.value["cidr_blocks"]
      ipv6_cidr_blocks = egress.value["ipv6_cidr_blocks"]

    }
  }

  tags = {
    Name = var.security_group_web_name
  }
}


resource "aws_network_acl" "devopspro_lab_network_acl_public" {
  vpc_id     = aws_vpc.devopspro_lab_vpc.id
  subnet_ids = [aws_subnet.devopspro_lab_subnet_public.id]

  dynamic "ingress" {
    for_each = var.network_acl_public_ingresses
    content {
      protocol   = ingress.value["protocol"]
      rule_no    = ingress.value["rule_no"]
      action     = ingress.value["action"]
      cidr_block = ingress.value["cidr_block"]
      from_port  = ingress.value["from_port"]
      to_port    = ingress.value["to_port"]

    }
  }

  dynamic "egress" {
    for_each = var.network_acl_public_egresses
    content {
      protocol   = egress.value["protocol"]
      rule_no    = egress.value["rule_no"]
      action     = egress.value["action"]
      cidr_block = egress.value["cidr_block"]
      from_port  = egress.value["from_port"]
      to_port    = egress.value["to_port"]

    }
  }

  tags = {
    Name = var.network_acl_public_name
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

  dynamic "egress" {
    for_each = var.security_group_db_egresses
    content {
      description      = egress.value["description"]
      from_port        = egress.value["from_port"]
      to_port          = egress.value["to_port"]
      protocol         = egress.value["protocol"]
      cidr_blocks      = egress.value["cidr_blocks"]
      ipv6_cidr_blocks = egress.value["ipv6_cidr_blocks"]
    }
  }

  tags = {
    Name = var.security_group_db_name
  }
}


resource "aws_network_acl" "devopspro_lab_network_acl_private" {
  vpc_id     = aws_vpc.devopspro_lab_vpc.id
  subnet_ids = [aws_subnet.devopspro_lab_subnet_private.id]

  dynamic "ingress" {
    for_each = var.network_acl_private_ingresses
    content {
      protocol   = ingress.value["protocol"]
      rule_no    = ingress.value["rule_no"]
      action     = ingress.value["action"]
      cidr_block = ingress.value["cidr_block"]
      from_port  = ingress.value["from_port"]
      to_port    = ingress.value["to_port"]
    }
  }

  dynamic "egress" {
    for_each = var.network_acl_private_egresses
    content {
      protocol   = egress.value["protocol"]
      rule_no    = egress.value["rule_no"]
      action     = egress.value["action"]
      cidr_block = egress.value["cidr_block"]
      from_port  = egress.value["from_port"]
      to_port    = egress.value["to_port"]
    }
  }

  tags = {
    Name = var.network_acl_private_name
  }
}
