resource "hcloud_server" "dev" {
  count       = var.instances
  name        = "dev-server-${count.index}"
  image       = var.os_type
  server_type = var.server_type
  location    = var.location
  ssh_keys    = [hcloud_ssh_key.default.id]
  labels = {
    type = "dev"
  }
  user_data = file("user_data.yml")
}