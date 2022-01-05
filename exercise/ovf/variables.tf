variable "ignition" {
  type = string
  default = ""
  description = "string from ignition file"
}

variable "bootstrap_ignition_path" {
  type = string
}

variable "name" {
  type = string
  description = "host anme"
}