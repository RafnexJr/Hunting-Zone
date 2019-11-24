
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
  image = "centos-7-x64"
  name = "fleet01.${var.domain}"
  region = "${var.do_region}"
  size = "${var.do_size}"
  private_networking = true
  ssh_keys = [
      "${var.ssh_fingerprint}"
  ]
}

resource "digitalocean_droplet" "grr01" {
  image = "ubuntu-18-04-x64"
  name = "grr01.${var.domain}"
  region = "${var.do_region}"
  size = "${var.do_size}"
  private_networking = true
  ssh_keys = [
      "${var.ssh_fingerprint}"
  ]
}

resource "digitalocean_record" "a-fleet" {
  domain = "${var.domain}"
  type   = "A"
  name   = "fleet"
  value  = "${digitalocean_droplet.fleet01.ipv4_address}"
}

resource "digitalocean_record" "a-grr" {
  domain = "${var.domain}"
  type   = "A"
  name   = "grr"
  value  = "${digitalocean_droplet.grr01.ipv4_address}"
}