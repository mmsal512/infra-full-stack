# ============================================
#  Variables
# ============================================

variable "hcloud_token" {
  description = "Hetzner Cloud API Token"
  type        = string
  sensitive   = true
}

variable "server_name" {
  description = "Name of the server"
  type        = string
  default     = "infra-full-stack"
}

variable "server_type" {
  description = "Hetzner server type (cx22 = 2 vCPU, 4GB RAM — ~€4.5/month)"
  type        = string
  default     = "cx22"
}

variable "server_location" {
  description = "Server location"
  type        = string
  default     = "nbg1"
}

variable "server_image" {
  description = "OS image"
  type        = string
  default     = "ubuntu-24.04"
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}

variable "ssh_private_key_path" {
  description = "Path to SSH private key (for provisioning)"
  type        = string
  default     = "~/.ssh/id_ed25519"
  sensitive   = true
}

variable "ssh_port" {
  description = "Custom SSH port"
  type        = number
  default     = 2026
}