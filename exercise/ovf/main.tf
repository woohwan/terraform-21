provider "vsphere" {
  user           = "administrator@vsphere.local"
  password       = "whSY*0805*"
  vsphere_server = "vcsa.saltware.lab"
}

provider "ignition" {

}

locals {

  ignition = file(var.bootstrap_ignition_path)
  ignition_encoded = "data:text/plain;charset=utf-8;base64,${base64encode(local.ignition)}"

}

data "ignition_file" "hostname" {
  path = "/etc/hostname"
  mode = "755"

  content {
    content = var.name
  }
}

data "ignition_config" "vm" {
  merge {
    source = local.ignition_encoded
  }
  files = [
    data.ignition_file.hostname.rendered
  ]
}

data "vsphere_datacenter" "dc" {
  name = "Datacenter"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "mycluster"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore" {
  name          = "datastore1"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = "mycluster/Resources"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Retrieve template information on vsphere
data "vsphere_virtual_machine" "template" {
  name          = "coreos"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "bootstrap" {
  name                        = "bootstrap_vm"
  resource_pool_id            = data.vsphere_resource_pool.pool.id
  datastore_id                = data.vsphere_datastore.datastore.id
  folder                      = "ocp4-terra"
  guest_id                    = data.vsphere_virtual_machine.template.guest_id
  enable_disk_uuid            = true
  wait_for_guest_net_timeout  = "0"
  wait_for_guest_net_routable = "false"

  num_cpus = 4
  memory   = 8192


  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "disk0"
    size  = 120
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
  }

  extra_config = {
    "guestinfo.ignition.config.data"          = base64encode(data.ignition_config.vm.rendered)
    "guestinfo.ignition.config.data.encoding" = "base64"
    "guestinfo.afterburn.initrd.network-kargs" = "ip=172.20.0.253::172.20.0.1:255.255.252.0:bootstrap.ocp4-terra.steve-aws.com::none:172.20.2.230"
  }
}