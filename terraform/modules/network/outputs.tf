# # output "network_id" {
# #   value = openstack_networking_network_v2.network.id
# # }

# # output "subnet_id" {
# #   value = openstack_networking_subnet_v2.subnet.id
# # }


# output "internal_subnet_id" {
#   value = openstack_networking_subnet_v2.private_subnet.id
# }
# output "internal_network_id" {
#   value = openstack_networking_network_v2.private_network.id
# }

output "internal_network_id" {
  value = openstack_networking_network_v2.private_network.id
}

output "external_network_id" {
  value = var.external_network_id
}

# # output "network_id" {
# #   value = var.external_network_id
# # }