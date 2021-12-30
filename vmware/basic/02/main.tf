# define vSphere
data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}

# If you don't have any resource pools, put "/Resources" after cluster name
data "vsphere_resource_pool" "resource_pool" {
    name = "mycluster/Resources"
    datacenter_id = data.vsphere_datacenter.dc.id
}

# Retrieve datastore information on vsphere
data "vsphere_datastore" "datastore" {
  name = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name = var.vsphere_cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}


# Retrieve network information on vsphere
data "vsphere_network" "network" {
  name = var.vsphere_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Contents libraray
data "vsphere_content_library" "library" {
  name = var.library_name
}

# library item
data "vsphere_content_library_item" "item" {
  name       = var.library_item_name
  library_id = data.vsphere_content_library.library.id
}

# Retrieve template information on vsphere
# data "vsphere_virtual_machine" "template" {
#   name = "/${var.vsphere_datacenter}/vm/${var.vsphere_template_folder}/${var.vsphere_vm_template_name}"
#   datacenter_id = data.vsphere_datacenter.dc.id
# }

resource "vsphere_virtual_machine" "vm" {
  for_each = var.hostnames_ip_addresses

  name = element(split(".", each.key), 0)

  resource_pool_id = data.vsphere_resource_pool.resource_pool.id
  datastore_id = data.vsphere_datastore.datastore.id
  guest_id = data.vsphere_virtual_machine.template.guest_id
  folder = var.folder_path
  enable_disk_uuid = true

  # set network parameter
  network_interface {
    network_id = data.vsphere_network.network.id
  }

  num_cpus = var.num_cpus
  memory = var.memory

  disk {
    label = "disk0"
    size = 60
    thin_provisioned = false
  }

  clone {
      # template_uuid = data.vsphere_virtual_machine.template.id
      template_uuid = data.vsphere_content_library_item.item.id
  }

  extra_config = {
    "guestinfo.ignition.config.data.enconding" = "base64"
    "guestinfo.afterburn.initrd.network-kargs" = "ip=${each.value}::${cidrhost(var.machine_cider,1)}:${cidrnetmask(var.machine_cider)}:${element(split(".", each.key), 0)}:ens192:none:${join(":", var.dns_addresses)}"
  }

}
