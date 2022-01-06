provider "vsphere" {
  user           = "administrator@vsphere.local"
  password       = "whSY*0805*"
  vsphere_server = "vcsa.saltware.lab"
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

variable "folder" {
  type = string
}

variable "bootstrap_ignition_path" {
  type    = string
  default = ""
}