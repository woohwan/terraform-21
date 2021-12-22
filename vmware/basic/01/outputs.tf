output "dc_id" {
  value = data.vsphere_datacenter.dc.id
}

output "resource_pool_id" {
  value = data.vsphere_resource_pool.pool.id
}