terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
    }
  }
}

provider "openstack" {
  auth_url         = var.os_auth_url
  tenant_id        = var.os_project_id
  tenant_name      = var.os_project_name
  user_domain_name = var.os_user_domain_name
  project_domain_id= var.os_project_domain_id
  user_name        = var.os_username
  password         = var.os_password
  region           = var.os_region_name
  endpoint_type    = var.os_interface
}

module "network" {
  source = "./modules/network"
  network_name      = var.network_name
  subnet_name       = var.subnet_name
  cidr              = var.cidr
  gateway_ip        = var.gateway_ip
  dns_nameservers   = var.dns_nameservers
  external_network_id = var.external_network_id
}


module "security_group" {
  source = "./modules/security_group"
}

module "volume_orchestration" {
  source      = "./modules/volume"
  instance_name = "orchestration"
  image_id      = var.image_id
  volume_size   = var.volume_size
  region        = var.os_region_name
}


module "instance" {
  source = "./modules/instance"
  image_id          = var.image_id
  flavor_id         = var.flavor_id
  key_pair          = var.key_pair
  external_network_id = module.network.external_network_id
  internal_network_id = module.network.internal_network_id
  network_id          = module.network.external_network_id
  instance_name     = "orchestration"
  security_group_ids= [module.security_group.security_group_id]
  volume_id        = module.volume_orchestration.volume_id
}





module "volume_QAS" {
  source      = "./modules/volume"
  instance_name = "QAS"
  image_id      = var.image_id
  volume_size   = var.volume_size
  region        = var.os_region_name
}
module "QAS" {
  source = "./modules/instance"
  image_id          = var.image_id
  flavor_id         = var.flavor_id
  key_pair          = var.key_pair
  external_network_id = module.network.external_network_id
  internal_network_id = module.network.internal_network_id
  network_id          = module.network.external_network_id
  instance_name     = "QAS"
  security_group_ids= [module.security_group.security_group_id]
  volume_id        = module.volume_QAS.volume_id
  
}

module "volume_artifact" {
  source      = "./modules/volume"
  instance_name = "artifact"
  image_id      = var.image_id
  volume_size   = var.volume_size
  region        = var.os_region_name
}
module "artifact" {
  source = "./modules/instance"
  image_id          = var.image_id
  flavor_id         = var.flavor_id
  key_pair          = var.key_pair
  external_network_id = module.network.external_network_id
  internal_network_id = module.network.internal_network_id
  network_id          = module.network.external_network_id
  instance_name     = "artifact"
  security_group_ids= [module.security_group.security_group_id]
  volume_id        = module.volume_artifact.volume_id
  
}


module "volume_monitoring_trafic" {
  source      = "./modules/volume"
  instance_name = "monitoring_trafic"
  image_id      = var.image_id
  volume_size   = var.volume_size
  region        = var.os_region_name
}
module "monitoring_trafic" {
  source = "./modules/instance"
  image_id          = var.image_id
  flavor_id         = var.flavor_id
  key_pair          = var.key_pair
  external_network_id = module.network.external_network_id
  internal_network_id = module.network.internal_network_id
  network_id          = module.network.external_network_id
  instance_name     = "monitoring_trafic"
  security_group_ids= [module.security_group.security_group_id]
  volume_id        = module.volume_monitoring_trafic.volume_id
  
}

# module "volume_Worker_1" {
#   source      = "./modules/volume"
#   instance_name = "Worker_1"
#   image_id      = var.image_id
#   volume_size   = var.volume_size
#   region        = var.os_region_name
# }
# module "Worker_1" {
#   source = "./modules/instance"
#   image_id          = var.image_id
#   flavor_id         = var.flavor2_id
#   key_pair          = var.key_pair
#   external_network_id = module.network.external_network_id
#   internal_network_id = module.network.internal_network_id
#   network_id          = module.network.external_network_id
#   instance_name     = "Worker_1"
#   security_group_ids= [module.security_group.security_group_id]
#   volume_id        = module.volume_Worker_1.volume_id
  
# }

# module "volume_Worker_2" {
#   source      = "./modules/volume"
#   instance_name = "Worker_2"
#   image_id      = var.image_id
#   volume_size   = var.volume_size
#   region        = var.os_region_name
# }
# module "Worker_2" {
#   source = "./modules/instance"
#   image_id          = var.image_id
#   flavor_id         = var.flavor2_id
#   key_pair          = var.key_pair
#   external_network_id = module.network.external_network_id
#   internal_network_id = module.network.internal_network_id
#   network_id          = module.network.external_network_id
#   instance_name     = "Worker_2"
#   security_group_ids= [module.security_group.security_group_id]
#   volume_id        = module.volume_Worker_2.volume_id
  
# }


# module "volume_Monitoring" {
#   source      = "./modules/volume"
#   instance_name = "Monitoring"
#   image_id      = var.image_id
#   volume_size   = var.volume_size
#   region        = var.os_region_name
# }
# module "Monitoring" {
#   source = "./modules/instance"
#   image_id          = var.image_id
#   flavor_id         = var.flavor2_id
#   key_pair          = var.key_pair
#   network_id        = module.network.network_id
#   instance_name     = "Monitoring"
#   security_group_ids= [module.security_group.security_group_id]
#   volume_id        = module.volume_Monitoring.volume_id
  
# }

