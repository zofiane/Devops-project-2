output "security_group_id" {
  value = openstack_networking_secgroup_v2.instance_secgroup.id
}
