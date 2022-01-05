terraform {
  required_providers {
    ignition = {
      source  = "community-terraform-providers/ignition"
      version = "2.1.2"
    }
  }

  required_version = ">= 0.13"
}