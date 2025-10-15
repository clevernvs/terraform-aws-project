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
