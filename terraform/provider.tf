# ============================================
#  Terraform Provider — Hetzner Cloud
#  Used for: Portfolio demonstration of IaC
#  Note: Server already exists on Hostinger,
#        Terraform manages the "concept" and
#        can provision new servers on Hetzner
# ============================================

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}