vsphere_user = "administrator@vsphere.local"
vsphere_password = "whSY*0805*"
vsphere_server = "vcsa.saltware.lab"
vsphere_datacenter = "Datacenter"
vsphere_datastore = "datastore1"
vsphere_cluster = "mycluster"
vsphere_network = "VM Network"
vsphere_template_folder = "templates"
vsphere_vm_template_name = "coreos"

# vm info
hostnames_ip_addresses = {
  "test-vm.ocp4.steve-aws.com" = "172.20.2.150"
}

num_cpus = "2"
memory = "4096"
// guest_id = "centos8_64_guest"
folder_path = "/Datacenter/vm/starter"
machine_cider = "172.20.2.0/22"
dns_addresses = [ "1.1.1.1","9.9.9.9" ]