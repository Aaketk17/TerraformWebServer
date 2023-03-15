variable "webserver_ami" {
  type    = string
  default = "ami-02238ac43d6385ab3"
}

variable "webserver_intanceType" {
  type    = string
  default = "t2.micro"
}

variable "webserver_vpc_id" {
  type = string
}

variable "webserver_subnet_id" {
  type = string
}

variable "instance_az" {
  type = string
}

variable "private_ip_id" {
  type = string
}

variable "igw_res" {
  type = any
}

variable "pem_key" {
  type = string
}

