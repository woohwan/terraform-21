variable "vsphere_user" {
  type = string
}

variable "vsphere_password" {
  type = string
}

variable "vsphere_server" {
  type = string
}

variable "vsphere_datacenter" {
  type = string
}

variable "vsphere_datastore" {
  type = string
}

variable "vsphere_cluster" {
  type = string
}

variable "vsphere_network" {
  type = string
}

variable "vsphere_template_folder" {
  type = string
}

variable "vsphere_vm_template_name" {
  type = string
}

variable "hostnames_ip_addresses" {
  type = map(string)
}

variable "num_cpus" {
  type = string
}

variable "memory" {
  type = string
}

variable "folder_path" {
  type = string
}

variable "machine_cider" {
  type = string
}

variable "dns_addresses" {
  type = list(string)
}