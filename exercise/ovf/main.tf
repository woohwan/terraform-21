terraform {
  required_providers {
    vsphere = "1.26.0"
  }
}

provider "vsphere" {
  user = "administrator@vsphere.local"
  password = "whSY*0805*"
  vsphere_server = "vcsa.saltware.lab"
}

data "vsphere_datacenter" "dc" {
  name = "Datacenter"
}

data "vsphere_compute_cluster" "cluster" {
  name = "mycluster"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore" {
  name = "datastore1"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name = "mycluster/Resources"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name = "VM Network"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_content_library" "library" {
  name = "rhcos"
}

data "vsphere_content_library_item" "item" {
  name = "rhcos-4.7.33"
  type = "ova"
  library_id = data.vsphere_content_library.library.id
}

locals {
  ignition = file("./ocp4-terra/merge-bootstrap.ign")
}

# Retrieve template information on vsphere
data "vsphere_virtual_machine" "template" {
  name = "coreos"
  datacenter_id = data.vsphere_datacenter.dc.id
}


resource "vsphere_virtual_machine" "vm_from_template" {
  name = "template_vm"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id = data.vsphere_datastore.datastore.id
  folder = "ocp4-terra-bz6rx"
#   guest_id = "rhel7_64Guest"
  guest_id = data.vsphere_virtual_machine.template.guest_id
  enable_disk_uuid = true
  wait_for_guest_net_timeout  = "0"
  wait_for_guest_net_routable = "false"

  num_cpus = 4
  memory = 8192
  

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "Hard disk 1"
    size = 120
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    # template_uuid = data.vsphere_content_library_item.item.id
  }

  extra_config = {
    # "guestinfo.ignition.config.data"           = base64encode(local.ignition)
    "guestinfo.ignition.config.data"           = "ewogICJpZ25pdGlvbiI6IHsKICAgICJjb25maWciOiB7CiAgICAgICJtZXJnZSI6IFsKICAgICAgICB7CiAgICAgICAgICAic291cmNlIjogImh0dHA6Ly8xNzIuMjAuMi4xMTAvb2NwNC9ib290c3RyYXAuaWduIiwgCiAgICAgICAgICAidmVyaWZpY2F0aW9uIjoge30KICAgICAgICB9CiAgICAgIF0KICAgIH0sCiAgICAidGltZW91dHMiOiB7fSwKICAgICJ2ZXJzaW9uIjogIjMuMi4wIgogIH0sCiAgIm5ldHdvcmtkIjoge30sCiAgInBhc3N3ZCI6IHt9LAogICJzdG9yYWdlIjoge30sCiAgInN5c3RlbWQiOiB7fQp9Cg=="
    "guestinfo.ignition.config.data.enconding" = "base64"
    "guestinfo.afterburn.initrd.network-kargs" = "ip=172.20.0.253::172.20.0.1:255.255.252.0:bootstrap.ocp4-terra.steve-aws.com::none:172.20.2.230"
  }
}