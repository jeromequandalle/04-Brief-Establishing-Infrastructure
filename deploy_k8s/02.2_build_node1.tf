
# Utiliser un null_resource avec for_each pour chaque serveur
resource "null_resource" "create_node1" {
  # Connexion SSH pour exécuter les commandes à distance
  connection {
    type        = "ssh"
    host        = var.ssh_host_firewall
    user        = var.ssh_user
    port        = var.ssh_host_node1_port
    private_key = file(var.ssh_key)  # Chemin vers la clé privée SSH
  }
  

  provisioner "file" {
         source =      "sh/create_node.sh"
         destination = "/tmp/create_node.sh"
         }

 
 provisioner "file" {
	 source	=	"conf/k8s.conf"
	 destination = "/tmp/k8s.conf"
    }

 provisioner "file" {
	 source	=	"conf/cri-dockerd_0.3.15.3-0.debian-bookworm_amd64.deb"
	 destination = "/tmp/cri-dockerd_0.3.15.3-0.debian-bookworm_amd64.deb"
    }

  # Provisioner pour exécuter des commandes à distance
  provisioner "remote-exec" {
    inline = [
      "cp /tmp/create_node.sh .",
      "chmod +x create_node.sh",
      "./create_node.sh"
      ]
  }

depends_on = [null_resource.upload_tok]
}

