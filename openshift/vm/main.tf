locals {
  ignition_encoded = "data:text/plain;charset=utf-8;base64,${base64encode(var.ignition)}"
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

resource "vsphere_virtual_machine" "vm" {

  # varaible for vsphere setting
  name             = var.name
  resource_pool_id = var.resource_pool_id
  datastore_id     = var.datastore
  folder           = var.folder
  guest_id         = var.guest_id
  enable_disk_uuid = true

  # vm spec
  num_cpus = var.num_cpus
  memory   = var.memory
  memory_reservation = var.memory

  # set network parameter
  network_interface {
    network_id = var.network
    adapter_type = var.adapter_type
  }
  
  disk {
    label            = "disk0"
    size             = var.disk_size
    thin_provisioned = var.thin_provisioned
  }

  clone {
    template_uuid = var.template
  }

  extra_config = {
    "guestinfo.ignition.config.data"           = base64encode(data.ignition_config.vm.rendered)
    "guestinfo.ignition.config.data.enconding" = "base64"
    "guestinfo.afterburn.initrd.network-kargs" = "ip=${var.ipv4_address}::${var.gateway}:${var.netmask}:${var.name}:ens192:none:${var.dns_address}"
  }

}
