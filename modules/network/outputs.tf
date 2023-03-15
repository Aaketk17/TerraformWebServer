output "subnet_output" {
  value = aws_subnet.web_server_subnet.id
}

output "vpc_output" {
  value = aws_vpc.web_server_vpc.id
}

output "igw_output" {
  value = aws_internet_gateway.webserver_igw
}
