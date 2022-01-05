# OCP Cluster vars
variable "cluster_slug" {
  type = string
}

variable "vmware_folder" {
  type = string
}

variable "bootstrap_complete" {
  type    = string
  default = "false"
}

# VMWare vars
variable "rhcos_template" {
  type = string
}

provider "vsphere" {
  user           = yamldecode(file("./config/ocp/vsphere.yaml"))["vsphere-user"]
  password       = yamldecode(file("./config/ocp/vsphere.yaml"))["vsphere-password"]
  vsphere_server = yamldecode(file("./config/ocp/vsphere.yaml"))["vsphere-server"]
}

data "vsphere_datacenter" "dc" {
  name = yamldecode(file("./config/ocp/vsphere.yaml"))["vsphere-dc"]
}

data "vsphere_compute_cluster" "cluster" {
  name          = yamldecode(file("./config/ocp/vsphere.yaml"))["vsphere-cluster"]
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Retrieve datastore information on vsphere
data "vsphere_datastore" "datastore" {
  name          = "datastore1"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Retrieve network information on vsphere
data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.dc.id
}

###############
## Ignition

provider "ignition" {

}

variable "ignition" {
  type    = string
  default = ""
}

################
# Machine variable

variable "bootstrap_ignition_path" {
  type    = string
  default = ""
}

variable "bootstrap_ip" {
  type    = string
  default = ""
}

variable "cluster_domain" {
  type = string
}

# variable "machine_cidr" {
#   type = string
# }

variable "gateway" {
  type = string
}

variable "local_dns" {
  type = string
}

variable "netmask" {
  type = string
}