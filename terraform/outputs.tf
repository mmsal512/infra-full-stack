output "server_ip" {
  description = "Public IPv4 address"
  value       = hcloud_server.main.ipv4_address
}

output "server_ipv6" {
  description = "Public IPv6 address"
  value       = hcloud_server.main.ipv6_address
}

output "server_status" {
  description = "Server status"
  value       = hcloud_server.main.status
}

output "server_type" {
  description = "Server type"
  value       = hcloud_server.main.server_type
}

output "ssh_command" {
  description = "SSH command to connect"
  value       = "ssh -p ${var.ssh_port} root@${hcloud_server.main.ipv4_address}"
}

output "ansible_inventory" {
  description = "Ansible inventory entry"
  value       = "${var.server_name} ansible_host=${hcloud_server.main.ipv4_address} ansible_user=root ansible_port=${var.ssh_port}"
}