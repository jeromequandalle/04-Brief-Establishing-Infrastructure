
provider "null" {}

resource "null_resource" "download_tok" {
  depends_on = [null_resource.create_master]
  provisioner "local-exec" {
    command = <<EOT
sftp -o StrictHostKeyChecking=no -P ${var.ssh_host_master_port} univers@${var.ssh_host_firewall}<<EOF
get /home/univers/tok.tok ./tok.tok
bye
EOF
EOT
  }
}

resource "null_resource" "upload_tok" {
  depends_on = [null_resource.download_tok]

  
  provisioner "local-exec" {
    command = <<EOT
sftp -o StrictHostKeyChecking=no -P ${var.ssh_host_node1_port} univers@${var.ssh_host_firewall} <<EOF
put ./tok.tok /home/univers/tok.tok
bye
EOF
EOT
  }
}


resource "null_resource" "upload_tok2" {
  depends_on = [null_resource.upload_tok]
  provisioner "local-exec" {
    command = <<EOT
sftp -o StrictHostKeyChecking=no -P ${var.ssh_host_node2_port} univers@${var.ssh_host_firewall} <<EOF
put ./tok.tok /home/univers/tok.tok
bye
EOF
EOT
  }
}
