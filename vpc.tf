resource "aws_vpc" "devopspro_lab_vpc" {
  cidr_block = var.project_vpc_cidr_block

  tags = {
    Name = var.project_vpc_name
  }
}

resource "aws_subnet" "devopspro_lab_subnet_public" {
  vpc_id     = aws_vpc.devopspro_lab_vpc.id
  cidr_block = var.project_subnet_public_cidr_block

  tags = {
    Name = var.project_subnet_public_name
  }
}

resource "aws_subnet" "devopspro_lab_subnet_private" {
  vpc_id     = aws_vpc.devopspro_lab_vpc.id
  cidr_block = var.project_subnet_private_cidr_block

  tags = {
    Name = var.project_subnet_private_name
  }
}

resource "aws_internet_gateway" "devopspro_lab_igw" {
  tags = {
    Name = var.project_internet_gateway_name
  }
}

resource "aws_internet_gateway_attachment" "devopspro_lab_igw_vpc_attach" {
  internet_gateway_id = aws_internet_gateway.devopspro_lab_igw.id
  vpc_id              = aws_vpc.devopspro_lab_vpc.id
}

resource "aws_eip" "devopspro_lab_nat_eip" {
  depends_on = [aws_internet_gateway.devopspro_lab_igw]

  tags = {
    Name = var.project_nat_eip_name
  }
}

resource "aws_nat_gateway" "devopspro_lab_nat_gtw" {
  allocation_id = aws_eip.devopspro_lab_nat_eip.id
  subnet_id     = aws_subnet.devopspro_lab_subnet_public.id

  tags = {
    Name = var.project_nat_gtw_name
  }

  depends_on = [aws_internet_gateway.devopspro_lab_igw]
}

resource "aws_route_table" "devopspro_lab_rt_public" {
  vpc_id = aws_vpc.devopspro_lab_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devopspro_lab_igw.id
  }

  tags = {
    Name = var.project_rt_public_name
  }
}

resource "aws_route_table_association" "devopspro_lab_rt_public_a" {
  subnet_id      = aws_subnet.devopspro_lab_subnet_public.id
  route_table_id = aws_route_table.devopspro_lab_rt_public.id
}

resource "aws_route_table" "devopspro_lab_rt_private" {
  vpc_id = aws_vpc.devopspro_lab_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_internet_gateway.devopspro_lab_nat_gtw.id
  }

  tags = {
    Name = var.project_rt_private_name
  }
}

resource "aws_route_table_association" "devopspro_lab_rt_private_a" {
  subnet_id      = aws_subnet.devopspro_lab_subnet_private.id
  route_table_id = aws_route_table.devopspro_lab_rt_private.id
}

