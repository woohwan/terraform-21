## Node IPs
bootstrap_ip = "172.20.0.253"
# control_plane_ips = [ "172.20.0.100", "172.20.0.101", "172.20.0.102" ]
## Cluster configuration
vmware_folder  = "ocp4-terra"
rhcos_template = "coreos"
cluster_slug   = "ocp4-terra"
cluster_domain = "ocp4-terra.steve-aws.com"
# machine_cidr   = "192.168.5.0/20"
netmask        = "255.255.252.0"

## DNS
local_dns  = "172.20.2.230"
# public_dns = "1.1.1.1"
gateway    = "172.20.0.1"

## Ignition paths
bootstrap_ignition_path         = "./ocp4-terra/bootstrap.ign"
# control_plane_ignition_path     = "./ocp4-terra/master.ign"