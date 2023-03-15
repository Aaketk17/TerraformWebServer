// 1. create VPC
resource "aws_vpc" "web_server_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "WebServerVPC"
  }
}

// 2. create Subnet within it
resource "aws_subnet" "web_server_subnet" {
  depends_on = [
    aws_vpc.web_server_vpc
  ]
  vpc_id            = aws_vpc.web_server_vpc.id
  cidr_block        = var.subnet_cidr
  availability_zone = var.subnet_az

  tags = {
    Name = "WebServerSubnet"
  }
}

// 3. Create IGW
resource "aws_internet_gateway" "webserver_igw" {
  depends_on = [
    aws_vpc.web_server_vpc
  ]
  vpc_id = aws_vpc.web_server_vpc.id

  tags = {
    Name = "WebServerIGW"
  }
}

// 4. Attach IGW to VPC
# resource "aws_internet_gateway_attachment" "webserver_igw_attachment" {
#   internet_gateway_id = aws_internet_gateway.webserver_igw.id
#   vpc_id              = aws_vpc.web_server_vpc.id
# }

// 4. Create RT
resource "aws_route_table" "webserver_rt" {
  depends_on = [
    aws_vpc.web_server_vpc,
    aws_internet_gateway.webserver_igw
  ]
  vpc_id = aws_vpc.web_server_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.webserver_igw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.webserver_igw.id
  }

  tags = {
    Name = "WebServerRT"
  }
}

// 5. Associate subnet with the RT
resource "aws_route_table_association" "webserver_rt_association" {
  depends_on = [
    aws_subnet.web_server_subnet,
    aws_route_table.webserver_rt
  ]
  subnet_id      = aws_subnet.web_server_subnet.id
  route_table_id = aws_route_table.webserver_rt.id
}





