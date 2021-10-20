output "catapp_url" {
  value = "http://${ncloud_public_ip.hashicat.public_ip}"
}

output "ssh_pw" {
  value = nonsensitive("sshpass -p '${data.ncloud_root_password.hashicat.root_password}' ssh root@${ncloud_public_ip.hashicat.public_ip} -oStrictHostKeyChecking=no")
}