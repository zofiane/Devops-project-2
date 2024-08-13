variable "os_auth_url" {}
variable "os_project_id" {}
variable "os_project_name" {}
variable "os_user_domain_name" {}
variable "os_project_domain_id" {}
variable "os_username" {}
variable "os_password" {}
variable "os_region_name" {}
variable "os_interface" {}

# variable "internal_network_id" {}
variable "external_network_id" {}

variable "network_name" {}
variable "subnet_name" {}
variable "cidr" {}
variable "gateway_ip" {}
variable "dns_nameservers" {
  type = list(string)
}

variable "image_id" {}
variable "flavor_id" {}
variable "key_pair" {}
variable "flavor2_id" {}
#variable "instance_name" {}

variable "volume_size" {
  description = "Size of the volume in GB"
  type        = number
}
