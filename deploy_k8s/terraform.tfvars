# Déclaration des variables promox_api
proxmox_api_token_id = "root@pam!terra"
proxmox_api_token_secret = "1e732b69-209c-47c7-9258-7d11ef0e0a83"
proxmox_api_url = "https://10.42.0.10:8006/api2/json"

#Déclaration des variables création des VMs
#Master
name_cluster_master = "srvk8smstr"
interfaces_clusters_ip0_master = "ip=172.42.10.80/24,gw=172.42.10.1"
interfaces_clusters_ip1_master = "ip=172.42.20.80/24"
id_master = "8022"
ssh_host_master_port = "8022"

#Node 1
name_cluster_node1 = "srvk8snd1"
interfaces_clusters_ip0_node1 = "ip=172.42.10.81/24,gw=172.42.10.1"
interfaces_clusters_ip1_node1 = "ip=172.42.20.81/24"

id_node1 = "8122"
ssh_host_node1_port = "8122"

#Node 2
name_cluster_node2 = "srvk8snd2"
interfaces_clusters_ip0_node2 = "ip=172.42.10.82/24,gw=172.42.10.1"
interfaces_clusters_ip1_node2 = "ip=172.42.20.82/24"
id_node2 = "8222"
ssh_host_node2_port = "8222"

#Commun
size_stockage_cluster = "30G"
ssh_key = "/home/univers/.ssh/id_ed25519"
ssh_user = "univers"
ssh_host_firewall = "10.42.0.5"

#Déclaration des variables information pve
node_name = "infra"
clone_name = "debian.template"
pool_k8s = "zone-exposee"
storage_cluster_k8s = "storage.exposee"
interfaces_clusters = "vmbr1"
interfaces_vlan_tag1 = "10"
interfaces_vlan_tag2 = "20"


#Déclaration des variable pour le cloud-init
ssh_key_pub = "/home/univers/.ssh/id_ed25519.pub"
ci_user = "univers"
ci_mdp  = "Dev0ps59"
dns_name = "mynet.net"
dns_ip = "1.1.1.2"