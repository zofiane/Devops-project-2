
# resource "openstack_networking_network_v2" "network" {
#   name = var.network_name
# }

# resource "openstack_networking_subnet_v2" "subnet" {
#   name            = var.subnet_name
#   network_id      = openstack_networking_network_v2.network.id
#   cidr            = var.cidr
#   ip_version      = 4
#   gateway_ip      = var.gateway_ip
#   dns_nameservers = var.dns_nameservers
# }

# output "network_id" {
#   value = var.external_network_id
# }


terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
    }
  }
}

resource "openstack_networking_network_v2" "private_network" {
  name = var.network_name
}

resource "openstack_networking_subnet_v2" "private_subnet" {
  name            = var.subnet_name
  network_id      = openstack_networking_network_v2.private_network.id
  cidr            = var.cidr
  ip_version      = 4
  gateway_ip      = var.gateway_ip
  dns_nameservers = var.dns_nameservers
}


# output "internal_network_id" {
#   value = openstack_networking_network_v2.private_network.id
# }

# output "internal_subnet_id" {
#   value = openstack_networking_subnet_v2.private_subnet.id
# }

# output "external_network_id" {
#   value = var.external_network_id
# }

# output "internal_network_id" {
#   value = openstack_networking_network_v2.private_network.id
# }
