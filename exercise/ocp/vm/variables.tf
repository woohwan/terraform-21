variable "ignition" {
  type = string
  default = ""
  description = "string from ignition file"
}

variable "name" {
  type = string
  description = "host anme"
}

variable "resource_pool_id" {
  type = string
}

variable "datastore_id" {
  type = string
}

variable "folder" {
  type = string
}

variable "guest_id" {
  type = string
}

variable "template" {
  type = string
}

variable "thin_provisioned" {
  type = string
}
variable "network" {
  type = string
}

variable "adapter_type" {
  type = string
}