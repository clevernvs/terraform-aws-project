# 
# Variáveis do Projeto
# 

variable "project_region" {
  type        = string
  default     = "us-east-1"
  description = "Região utilizada no projeto"
}

# 
# Variáveis da VPC 
# 

variable "project_vpc_name" {
  type        = string
  default     = "devopspro-lab-vpc"
  description = "Nome da VPC"
}

variable "project_vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "Cidr block da VPC"
}

variable "project_subnet_public_name" {
  type        = string
  default     = "devopspro-lab-subnet-public"
  description = "Nome da Subnet publica"
}

variable "project_subnet_public_cidr_block" {
  type        = string
  default     = "10.0.0.0/24"
  description = "Cidr block da Subnet publica"
}

variable "project_subnet_private_name" {
  type        = string
  default     = "devopspro-lab-subnet-private"
  description = "Cidr block da Subnet privada"
}

variable "project_subnet_private_cidr_block" {
  type        = string
  default     = "10.0.0.0/24"
  description = "Cidr block da Subnet privada"
}

variable "project_internet_gateway_name" {
  type        = string
  default     = "devopspro-lab-igw"
  description = "Nome da Internet Gateway"
}

variable "project_nat_eip_name" {
  type        = string
  default     = "devopspro-lab-nat-eip"
  description = "Nome do Elastic IP vinculado ao Nat Gateway"
}

variable "project_nat_gtw_name" {
  type        = string
  default     = "devopspro-lab-nat-gtw"
  description = "Nome do Nat Gateway"
}

variable "project_rt_public_name" {
  type        = string
  default     = "devopspro-lab-rt-public"
  description = "Nome do Route Table Publica"
}

variable "project_rt_private_name" {
  type        = string
  default     = "devopspro-lab-rt-private"
  description = "Nome do Route Table Privada"
}

# 
# Variáveis das EC2 
# 

variable "ec2_ami" {
  type        = string
  default     = "ami-053b0d53c279acc90"
  description = "ID da imagem Amazon"
}

variable "web_ec2_name" {
  type        = string
  default     = "web-ec2"
  description = "ID da imagem Amazon"
}

variable "web_ec2_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "ID da imagem Amazon"
}

variable "db_ec2_name" {
  type        = string
  default     = "db-ec2"
  description = "ID da imagem Amazon"
}

variable "db_ec2_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "ID da imagem Amazon"
}

variable "key_pair_ssh_name" {
  type        = string
  default     = "devopspro-labs-key"
  description = "ID da imagem Amazon"
}

variable "key_pair_ssh_file" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
  description = "ID da imagem Amazon"
}

# 
# Variáveis das Security 
# 

variable "security_group_web_name" {
  type        = string
  default     = "devopspro-lab-sg-web"
  description = "ID da imagem Amazon"
}

variable "security_group_web_ingresses" {
  default = [
    {
      description      = "Acesso HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Acesso HTTPs"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Acesso SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]

}

variable "security_group_web_egresses" {
  default = [
    {
      description      = "Acesso HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Acesso HTTPs"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Acesso DNS"
      from_port        = 53
      to_port          = 53
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Acesso DNS"
      from_port        = 53
      to_port          = 53
      protocol         = "udp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Acesso SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Acesso MongoDB"
      from_port        = 27017
      to_port          = 27017
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]
}


variable "network_acl_public_name" {
  type        = string
  default     = "devopspro-lab-network-acl-public"
  description = "ID da imagem Amazon"
}

variable "network_acl_public_ingresses" {
  default = [
    # Portas HTTP
    {
      protocol   = "tcp"
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0./0"
      from_port  = 80
      to_port    = 80
    },
    # Portas HTTPs
    {
      protocol   = "tcp"
      rule_no    = 110
      action     = "allow"
      cidr_block = "0.0.0./0"
      from_port  = 443
      to_port    = 443
    },
    # Portas SSH
    {
      protocol   = "tcp"
      rule_no    = 120
      action     = "allow"
      cidr_block = "0.0.0./0"
      from_port  = 22
      to_port    = 22
    },
    # Portas Efemeras
    {
      protocol   = "tcp"
      rule_no    = 130
      action     = "allow"
      cidr_block = "0.0.0./0"
      from_port  = 1024
      to_port    = 65535
    },
    # Portas DNS (tcp)
    {
      protocol   = "tcp"
      rule_no    = 140
      action     = "allow"
      cidr_block = "0.0.0./0"
      from_port  = 53
      to_port    = 53
    },
    # Portas DNS (udp)
    {
      protocol   = "udp"
      rule_no    = 150
      action     = "allow"
      cidr_block = "0.0.0./0"
      from_port  = 53
      to_port    = 53
    }
  ]
}

variable "network_acl_public_egresses" {
  default = [
    # Portas Efemeras
    {
      protocol   = "tcp"
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0./0"
      from_port  = 1024
      to_port    = 65535
    },
    # Portas HTTP
    {
      protocol   = "tcp"
      rule_no    = 110
      action     = "allow"
      cidr_block = "0.0.0./0"
      from_port  = 80
      to_port    = 80
    },
    # Portas HTTPs
    {
      protocol   = "tcp"
      rule_no    = 120
      action     = "allow"
      cidr_block = "0.0.0./0"
      from_port  = 443
      to_port    = 443
    },
    # Portas DNS (tcp)
    {
      protocol   = "tcp"
      rule_no    = 130
      action     = "allow"
      cidr_block = "0.0.0./0"
      from_port  = 53
      to_port    = 53
    },
    # Portas DNS (udp)
    {
      protocol   = "udp"
      rule_no    = 140
      action     = "allow"
      cidr_block = "0.0.0./0"
      from_port  = 53
      to_port    = 53
    },
    # Portas SSH
    {
      protocol   = "tcp"
      rule_no    = 150
      action     = "allow"
      cidr_block = "0.0.0./0"
      from_port  = 22
      to_port    = 22
    }
  ]
}

variable "security_group_db_name" {
  type        = string
  default     = "devopspro-lab-sg-db"
  description = "Nome do Security Group do Banco de Dados"
}

variable "security_group_db_egresses" {
  default = [
    {
      description      = "Acesso HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Acesso HTTPs"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Acesso DNS"
      from_port        = 53
      to_port          = 53
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Acesso DNS"
      from_port        = 53
      to_port          = 53
      protocol         = "udp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]
}

variable "network_acl_private_name" {
  type        = string
  default     = "devopspro-lab-network-acl-private"
  description = "Nome do Security Group do Banco de Dados"
}

variable "network_acl_private_ingresses" {
  default = [
    # Porta MongoDB
    {
      protocol   = "tcp"
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0./0"
      from_port  = 27017
      to_port    = 27017
    },
    # Porta SSH
    {
      protocol   = "tcp"
      rule_no    = 110
      action     = "allow"
      cidr_block = "0.0.0./0"
      from_port  = 22
      to_port    = 22
    },
    # Portas Efemeras
    {
      protocol   = "tcp"
      rule_no    = 120
      action     = "allow"
      cidr_block = "0.0.0./0"
      from_port  = 1024
      to_port    = 65535
    }
  ]
}

variable "network_acl_private_egresses" {
  default = [
    # Portas Efemeras
    {
      protocol   = "tcp"
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0./0"
      from_port  = 1024
      to_port    = 65535
    },
    # Portas HTTP
    {
      protocol   = "tcp"
      rule_no    = 110
      action     = "allow"
      cidr_block = "0.0.0./0"
      from_port  = 80
      to_port    = 80
    },
    # Portas HTTPs
    {
      protocol   = "tcp"
      rule_no    = 120
      action     = "allow"
      cidr_block = "0.0.0./0"
      from_port  = 443
      to_port    = 443
    },
    # Portas DNS (tcp)
    {
      protocol   = "tcp"
      rule_no    = 130
      action     = "allow"
      cidr_block = "0.0.0./0"
      from_port  = 53
      to_port    = 53
    },
    # Portas DNS (udp)
    {
      protocol   = "udp"
      rule_no    = 140
      action     = "allow"
      cidr_block = "0.0.0./0"
      from_port  = 53
      to_port    = 53
    }
  ]
}
