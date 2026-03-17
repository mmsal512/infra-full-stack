# ============================================
#  SSH Key
# ============================================
resource "hcloud_ssh_key" "default" {
  name       = "${var.server_name}-key"
  public_key = file(var.ssh_public_key_path)
}

# ============================================
#  Firewall — Matching your security standards
# ============================================
resource "hcloud_firewall" "default" {
  name = "${var.server_name}-fw"

  # Custom SSH port (matching your setup)
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = tostring(var.ssh_port)
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  # Kubernetes API (K3s)
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "6443"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  # NodePort range for K8s services
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "30000-32767"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  # Note: HTTP/HTTPS NOT opened — access via Cloudflare Tunnel
  # This matches the production architecture
}

# ============================================
#  Server
# ============================================
resource "hcloud_server" "main" {
  name        = var.server_name
  server_type = var.server_type
  location    = var.server_location
  image       = var.server_image
  ssh_keys    = [hcloud_ssh_key.default.id]
  firewall_ids = [hcloud_firewall.default.id]

  labels = {
    environment = "production"
    managed_by  = "terraform"
    project     = "infra-full-stack"
    owner       = "admin"
  }

  connection {
    type        = "ssh"
    user        = "root"
    private_key = file(var.ssh_private_key_path)
    host        = self.ipv4_address
  }

  provisioner "remote-exec" {
    inline = [
      "cloud-init status --wait",
      "echo '✅ Server is ready for Ansible provisioning!'"
    ]
  }
}