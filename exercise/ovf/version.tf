terraform {
  required_providers {
    vsphere = "1.26.0"
    ignition = {
      source  = "community-terraform-providers/ignition"
      version = "2.1.2"
    }
  }
}