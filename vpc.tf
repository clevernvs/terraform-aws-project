resource "aws_vpc" "devopspro_lab_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "devopspro-lab-vpc"
  }
}

resource "aws_subnet" "devopspro_lab_subnet_public" {
  vpc_id     = aws_vpc.devopspro_lab_vpc.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "devopspro-lab-subnet-public"
  }
}

resource "aws_subnet" "devopspro_lab_subnet_public" {
  vpc_id     = aws_vpc.devopspro_lab_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "devopspro-lab-subnet-public"
  }
}
