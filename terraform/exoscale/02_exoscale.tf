variable "exo_api_url" {}
variable "exo_api_key" {}
variable "exo_secret_key" {}
variable "exo_keypair" {}
variable "exo_domain" {}


resource "exoscale_security_group" "gateways" {
  name        = "gateways"
  description = "Gateways that bridge local and public networks"
}

resource "exoscale_security_group" "jumphosts" {
  name        = "jumphosts"
  description = "Dedicated zone that has managment access to the systems"
} 

resource "exoscale_security_group" "internal" {
  name        = "internal"
  description = "Zone that can only communicate over the gateways"
} 

resource "exoscale_security_group_rules" "gateway_rules" {
    security_group = "${exoscale_security_group.gateways.name}"

    ingress {
        protocol = "TCP"
        ports = ["22", "3389"]
        user_security_group_list = "${exoscale_security_group.jumphosts.name}"
    }
}

resource "exoscale_security_group_rules" "jumphost_rules" {
    security_group = "${exoscale_security_group.internal.name}"


}

resource "exoscale_security_group_rules" "internal_rules" {
    security_group = "${exoscale_security_group.jumphosts.name}"

    ingress {
        protocol = "TCP"
        ports = ["22", "3389"]
        user_security_group_list = "${exoscale_security_group.jumphosts.name}"
    }

    egress {
        protocol = "TCP"
        ports = "1-65535"
        user_security_group_list = "${exoscale_security_group.gateways.name}"
    }

    egress {
        protocol = "UDP"
        ports = "1-65535"
        user_security_group_list = "${exoscale_security_group.gateways.name}"
    }
}

resource "exoscale_ssh_keypair" "exo-terra" {
    name    = "exo-terra"
}

data "exoscale_compute_template" "centos" {
  zone = "ch-dk-2"
  name = "Linux Centos 7.6 64-bit"
}

resource "exoscale_compute" "gw01" {
    zone            = "ch-dk-2"
    display_name    = "gw01"
    template_id     = "${data.exoscale_compute_template.centos.id}"
    size            = "Tiny"
    disk_size       = "50"
    key_pair        = "${exoscale_ssh_keypair.exo-terra.name}"
    state           = "Running"

    security_groups = [ ]

    ip6             = false
}