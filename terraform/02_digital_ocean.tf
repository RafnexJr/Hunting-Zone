
variable "do_token" {}
variable "do_region" {}

variable "do_image" {}
variable "do_size" {}
variable "pub_key" {}
variable "pvt_key" {}
variable "ssh_fingerprint" {}
variable "domain" {}

provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_droplet" "fleet01" {
  image = "${var.do_image}"
  name = "fleet01.${var.domain}"
  region = "${var.do_region}"
  size = "${var.do_size}"
  private_networking = true
  ssh_keys = [
      "${var.ssh_fingerprint}"
  ]
}

resource "digitalocean_record" "a-fleet01" {
  domain = "${var.domain}"
  type   = "A"
  name   = "fleet"
  value  = "${digitalocean_droplet.fleet01.ipv4_address}"
}