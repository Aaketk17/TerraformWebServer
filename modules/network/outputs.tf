output "subnet_output" {
  value = aws_subnet.web_server_subnet
}

output "vpc_output" {
  value = aws_vpc.web_server_vpc
}

output "igw_output" {
  value = aws_internet_gateway.webserver_igw
}
