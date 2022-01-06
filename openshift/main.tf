data "vsphere_virtual_machine" "template" {
  name          = var.rhcos_template
  datacenter_id = data.vsphere_datacenter.dc.id
}

module "bootstrap" {
  source    = "./vm"
  count     = "${var.bootstrap_complete ? 0 : 1}"
  name      = "${var.cluster_slug}-bootstrap"
  folder    = var.vmware_folder
  datastore = data.vsphere_datastore.datastore.id
  disk_size = 120
  memory    = 8192
  num_cpus  = 4
  ignition  = file(var.bootstrap_ignition_path)

  resource_pool_id = data.vsphere_resource_pool.pool.id
  guest_id         = data.vsphere_virtual_machine.template.guest_id
  template         = data.vsphere_virtual_machine.template.id
  thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned

  network      = data.vsphere_network.network.id
  adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]

  cluster_domain = var.cluster_domain
  dns_address    = var.local_dns
  gateway        = var.gateway
  ipv4_address   = var.bootstrap_ip
  netmask        = var.netmask
}