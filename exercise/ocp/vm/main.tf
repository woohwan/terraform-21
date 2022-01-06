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

resource "vsphere_virtual_machine" "bootstrap" {
  name                        = "bootstrap_vm"
  resource_pool_id            = var.resource_pool_id
  datastore_id                = var.datastore_id
  folder                      = var.folder
  guest_id                    = var.guest_id
  enable_disk_uuid            = true
  wait_for_guest_net_timeout  = "0"
  wait_for_guest_net_routable = "false"

  num_cpus = 4
  memory   = 8192


  network_interface {
    network_id = var.network
    adapter_type = var.adapter_type
  }

  disk {
    label = "disk0"
    size  = 120
    thin_provisioned = var.thin_provisioned
  }

  clone {
    template_uuid = var.template
  }

  extra_config = {
    "guestinfo.ignition.config.data"          = base64encode(data.ignition_config.vm.rendered)
    "guestinfo.ignition.config.data.encoding" = "base64"
    "guestinfo.afterburn.initrd.network-kargs" = "ip=172.20.0.253::172.20.0.1:255.255.252.0:bootstrap.ocp4-terra.steve-aws.com::none:172.20.2.230"
  }
}