terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
    }
  }
}

resource "openstack_compute_instance_v2" "instance" {
  name            = var.instance_name
  image_id        = var.image_id
  flavor_id       = var.flavor_id
  key_pair        = var.key_pair

  block_device {
    uuid                  = var.volume_id
    source_type           = "volume"
    destination_type      = "volume"
    boot_index            = 0
    delete_on_termination = true
  }

  network {
    uuid = var.external_network_id
  }

  network {
    uuid = var.internal_network_id
  }

  security_groups = var.security_group_ids

  // Optionnel: ajouter des metadata
  metadata = {
    "env" = "dev"
  }
}
