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

resource "aws_subnet" "devopspro_lab_subnet_private" {
  vpc_id     = aws_vpc.devopspro_lab_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "devopspro-lab-subnet-private"
  }
}

resource "aws_internet_gateway" "devopspro_lab_igw" {
  tags = {
    Name = "devopspro-lab-igw"
  }
}

resource "aws_internet_gateway_attachment" "devopspro_lab_igw_vpc_attach" {
  internet_gateway_id = aws_internet_gateway.devopspro_lab_igw.id
  vpc_id              = aws_vpc.devopspro_lab_vpc.id
}

resource "aws_eip" "devopspro_lab_nat_eip" {
  depends_on = [aws_internet_gateway.devopspro_lab_igw]

  tags = {
    Name = "devopspro-lab-nat-eip"
  }
}

resource "aws_nat_gateway" "devopspro_lab_nat_gtw" {
  allocation_id = aws_eip.devopspro_lab_nat_eip.id
  subnet_id     = aws_subnet.devopspro_lab_subnet_public.id

  tags = {
    Name = "devopspro-lab-nat-gtw"
  }

  depends_on = [aws_internet_gateway.devopspro_lab_igw]
}


