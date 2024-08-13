variable "network_name" {}
variable "subnet_name" {}
variable "cidr" {}
variable "gateway_ip" {}
variable "dns_nameservers" {
  type = list(string)
}


variable "external_network_id" {}
