# variable "image_id" {}
# variable "flavor_id" {}
# variable "key_pair" {}
# variable "network_id" {}
# variable "security_group_ids" {
#   type = list(string)
# }

variable "image_id" {}
variable "flavor_id" {}
variable "key_pair" {}
variable "network_id" {}
variable "instance_name" {}
variable "volume_id" {}

# variable "instance_names" {
#   type = list(string)
# }
variable "security_group_ids" {
  type = list(string)
}

variable "external_network_id" {
  description = "ID du réseau externe pour l'IP publique"
  type        = string
}

variable "internal_network_id" {
  description = "ID du réseau interne pour l'IP privée"
  type        = string
}

