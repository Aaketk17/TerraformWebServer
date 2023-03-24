# 1. Create Security Group to allow port 22,80,443
resource "aws_security_group" "webserver_sg" {
  name        = "allow_web_traffic"
  description = "Allow Web inbound traffic"
  vpc_id      = var.webserver_vpc_id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "WebServerSG"
  }
}

# 2. Create a network interface with an ip in the subnet that was created in step 4

resource "aws_network_interface" "webserver_nic" {
  subnet_id       = var.webserver_subnet_id
  private_ips     = [var.private_ip_id]
  security_groups = [aws_security_group.webserver_sg.id]
}

# 3. Assign an elastic IP to the network interface created in step 2

# resource "aws_eip" "webserver-eip" {
#   vpc                       = true
#   network_interface         = aws_network_interface.webserver_nic.id
#   associate_with_private_ip = var.private_ip_id
#   depends_on                = [var.igw_res]
# }

resource "aws_instance" "webServer_instance" {
  ami               = var.webserver_ami
  instance_type     = var.webserver_intanceType
  key_name          = var.pem_key
  availability_zone = var.instance_az

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.webserver_nic.id
  }
  tags = {
    Name = "WebServer"
  }
}
