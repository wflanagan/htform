#resource "hcloud_ssh_key" "nmkey" {
#  name       = "nm_key"
#  public_key = file("~/.ssh/tf_nm.pub")
#}
#
#resource "tls_private_key" "key" {
#  algorithm = "RSA"
#  rsa_bits  = 4096
#}

#resource "hcloud_ssh_key" "injectkey" {
#  name       = "inject_key"
#  public_key = tls_private_key.key.public_key_openssh
#}

data "hcloud_ssh_key" "get_hetzner_key" {
  name = "hetzner_key"
}