terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
    }

    template = {
      source = "hashicorp/template"
    }

    tls = {
      source = "hashicorp/tls"
    }

    random = {
      source = "hashicorp/random"
    }
  }
  required_version = ">= 0.13"
}