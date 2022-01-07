## Node IPs
# loadbalancer_ip = "192.168.5.160"
# coredns_ip = "192.168.5.169"
bootstrap_ip = "172.20.0.253"
master_ips = ["172.20.0.100", "172.20.0.101", "172.20.0.102"]
worker_ips = ["172.20.0.110", "172.20.0.111"]

## Cluster configuration
vmware_folder  = "ocp4-terra"
rhcos_template = "coreos"
cluster_slug   = ""
cluster_domain = "ocp4-terra.steve-aws.com"
# machine_cidr = "192.168.5.0/20"
netmask = "255.255.252.0"
## DNS
local_dns = "172.20.2.230" # probably the same as coredns_ip
# public_dns = "192.168.1.254" # e.g. 1.1.1.1
gateway = "172.20.0.1"
## Ignition paths
## Expects `openshift-install create ignition-configs` to have been run
## probably via generate-configs.sh
bootstrap_ignition_path = "./ocp4-terra/bootstrap.ign"
master_ignition_path = "./ocp4-terra/master.ign"
worker_ignition_path = "./ocp4-terra/worker.ign"