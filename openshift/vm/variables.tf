variable "name" {
  type = string
  description = "VM name on vSphere"
}

variable "ignition" {
  type = string
  description = "(optional) describe your variable"
}

variable "resource_pool_id" {
  type = string
  description = "resource pool id"
}

variable "folder" {
  type = string
  description = "folder where vm to be created"
}

variable "datastore" {
  type = string
}

variable "guest_id" {
  type = string
  description = "template guest id"
}

variable "num_cpus" {
  type = string
  description = "number of cpu"
}

variable "memory" {
  type = string
  description = "memory size (MB)"
}

variable "network" {
  type = string
  description = "newtowk where vm belongs to"
}

variable "adapter_type" {
  type = string
  description = "adapter_type which vm has"
}

variable "disk_size" {
  type = string
  description = "VM disk size"
}

variable "thin_provisioned" {
  type = string
  description = "whethere thin provisioned or not"
}

variable "template" {
  type = string
  description = "template id of vm to clone"
}

variable "ipv4_address" {
  type = string
  description = "vm ipv4 address"
}

variable "gateway" {
  type = string
  description = "vm gateway"
}

variable "netmask" {
  type = string
  description = "vm ipv4 netmask"
}

variable "dns_address" {
  type = string
  description = "dns address vm use"
}

variable "cluster_domain" {
  type = string
}

# variable "machine_cider" {
#   type = string
# }