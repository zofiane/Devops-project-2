# variable "instance_name" {}
# variable "image_id" {}
# variable "volume_size" {
#   type = number
# }
# variable "region" {}


terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
    }
  }
}

resource "openstack_blockstorage_volume_v3" "volume" {
  name      = var.instance_name
  size      = var.volume_size
  image_id  = var.image_id
  region    = var.region
}


