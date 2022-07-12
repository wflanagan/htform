output "dev_servers_status" {
  value = {
    for server in hcloud_server.web :
    server.name => server.status
  }
}

output "dev_servers_ips" {
  value = {
    for server in hcloud_server.web :
    server.name => server.ipv4_address
  }
}