module "bootstrap" {
  source   = "./vm"
  name     = "bootstrap"
  folder   = var.folder
  ignition = file(var.bootstrap_ignition_path)

  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  guest_id         = "${data.vsphere_virtual_machine.template.guest_id}"
  template         = "${data.vsphere_virtual_machine.template.id}"
  thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  
  network          = "${data.vsphere_network.network.id}"
  adapter_type     = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
}