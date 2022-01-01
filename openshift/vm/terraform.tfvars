vsphere_user             = "administrator@vsphere.local"
vsphere_password         = "whSY*0805*"
vsphere_server           = "vcsa.saltware.lab"
vsphere_datacenter       = "Datacenter"
vsphere_datastore        = "datastore1"
vsphere_cluster          = "mycluster"
vm_network               = "VM Network"
vsphere_template_folder  = "templates"
vsphere_vm_template_name = "coreos"
library_name             = "rhcos"
library_item_name        = "rhcos-4.7.33"

# bootstrap
hostnames_ip_addresses = {
  "bootstrap.ocp4.steve-aws.com" = "172.20.0.253"
}

disk_thin_provisioned = false
ignition              = "./ocp4-terra/merged-bootstrap.ign"


num_cpus = "4"
memory   = "16384"
// guest_id = "centos8_64_guest"
folder_path   = "/Datacenter/vm/ocp4-terra"
machine_cider = "172.20.2.0/22"
dns_addresses = ["172.20.2.230"]