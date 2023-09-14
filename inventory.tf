resource "local_file" "inventory_file" {
  content  = <<EOF
[webserver]
${aws_instance.webserver.public_ip}
[all:vars]
ansible_ssh_private_key = ~/.ssh/id_ed25519
ansible_connection="ssh"
  EOF
  filename = "${path.module}/inventory/webservers.ini"
}