terraform {
  required_providers {
    ncloud = {
      source  = "NaverCloudPlatform/ncloud"
      version = "~> 2.0"
    }
  }
}

provider "ncloud" {
  region      = var.region
  site        = var.site
  support_vpc = true
}

resource "ncloud_vpc" "hashicat" {
  ipv4_cidr_block = var.address_space
  name            = lower("${var.prefix}-vpc-${var.region}")
}

# resource "ncloud_network_acl" "hashicat" {
#   vpc_no      = ncloud_vpc.hashicat.id
#   name        = "${var.prefix}-acl-public"
#   description = "for Public"
# }

# resource "ncloud_subnet" "hashicat" {
#   name           = "${var.prefix}-subnet"
#   vpc_no         = ncloud_vpc.hashicat.id
#   subnet         = cidrsubnet(ncloud_vpc.hashicat.ipv4_cidr_block, 8, 1) # "10.0.1.0/24"
#   zone           = var.zone
#   network_acl_no = ncloud_network_acl.hashicat.id
#   subnet_type    = "PUBLIC"
#   usage_type     = "GEN"
# }

# locals {
#   public_subnet_inbound = [
#     [1, "TCP", "0.0.0.0/0", "80", "ALLOW"],
#     [2, "TCP", "0.0.0.0/0", "443", "ALLOW"],
#     [3, "TCP", "${var.client_ip}/32", "22", "ALLOW"],
#     [4, "TCP", "${var.client_ip}/32", "3389", "ALLOW"],
#     [5, "TCP", "0.0.0.0/0", "32768-65535", "ALLOW"],
#     [197, "TCP", "0.0.0.0/0", "1-65535", "DROP"],
#     [198, "UDP", "0.0.0.0/0", "1-65535", "DROP"],
#     [199, "ICMP", "0.0.0.0/0", null, "DROP"],
#   ]

#   public_subnet_outbound = [
#     [1, "TCP", "0.0.0.0/0", "80", "ALLOW"],
#     [2, "TCP", "0.0.0.0/0", "443", "ALLOW"],
#     [3, "TCP", "${var.client_ip}/32", "22", "ALLOW"],
#     [4, "TCP", "${var.client_ip}/32", "3389", "ALLOW"],
#     [5, "TCP", "0.0.0.0/0", "9001-65535", "ALLOW"],
#     [6, "TCP", "${ncloud_server.hashicat.network_interface[0].private_ip}/32", "8080", "ALLOW"],
#     # Allow 8080 port to private server
#     [197, "TCP", "0.0.0.0/0", "1-65535", "DROP"],
#     [198, "UDP", "0.0.0.0/0", "1-65535", "DROP"],
#     [199, "ICMP", "0.0.0.0/0", null, "DROP"]
#   ]
# }

# data "ncloud_access_control_group" "hashicat" {
#   id = ncloud_vpc.hashicat.default_access_control_group_no
# }

# resource "ncloud_access_control_group_rule" "hashicat" {
#   access_control_group_no = data.ncloud_access_control_group.hashicat.id

#   dynamic "inbound" {
#     for_each = local.public_subnet_inbound
#     content {
#       protocol   = inbound.value[1]
#       ip_block   = inbound.value[2]
#       port_range = inbound.value[3]
#     }
#   }

#   outbound {
#     protocol    = "TCP"
#     ip_block    = "0.0.0.0/0"
#     port_range  = "1-65535"
#     description = "accept 1-65535 port"
#   }
# }

# resource "ncloud_network_acl_rule" "hashicat" {
#   network_acl_no = ncloud_network_acl.hashicat.id
#   dynamic "inbound" {
#     for_each = local.public_subnet_inbound
#     content {
#       priority    = inbound.value[0]
#       protocol    = inbound.value[1]
#       ip_block    = inbound.value[2]
#       port_range  = inbound.value[3]
#       rule_action = inbound.value[4]
#     }
#   }

#   dynamic "outbound" {
#     for_each = local.public_subnet_outbound
#     content {
#       priority    = outbound.value[0]
#       protocol    = outbound.value[1]
#       ip_block    = outbound.value[2]
#       port_range  = outbound.value[3]
#       rule_action = outbound.value[4]
#     }
#   }
# }

# resource "ncloud_login_key" "hashicat" {
#   key_name = "${var.prefix}-key"
# }

# data "ncloud_server_images" "hashicat" {
#   filter {
#     name   = "product_name"
#     values = ["ubuntu-18.04?"]
#     regex  = true
#   }
#   filter {
#     name   = "product_code"
#     values = ["SW.VSVR.OS.LNX64.UBNTU.SVR1804.B050"]
#     regex  = true
#   }
# }

# data "ncloud_server_products" "hashicat" {
#   server_image_product_code = data.ncloud_server_images.hashicat.server_images[0].product_code

#   filter {
#     name   = "product_code"
#     values = ["SSD"]
#     regex  = true
#   }

#   filter {
#     name   = "cpu_count"
#     values = ["2"]
#   }

#   filter {
#     name   = "product_type"
#     values = ["STAND"]
#   }
# }

# resource "ncloud_server" "hashicat" {
#   subnet_no                 = ncloud_subnet.hashicat.id
#   name                      = "${var.prefix}-public"
#   server_image_product_code = data.ncloud_server_images.hashicat.server_images[0].product_code
#   login_key_name            = ncloud_login_key.hashicat.key_name
#   server_product_code       = data.ncloud_server_products.hashicat.server_products.0.product_code
# }

# data "ncloud_root_password" "hashicat" {
#   server_instance_no = ncloud_server.hashicat.id
#   private_key        = ncloud_login_key.hashicat.private_key
# }

# resource "ncloud_public_ip" "hashicat" {
#   server_instance_no = ncloud_server.hashicat.id
#   description        = "${var.prefix}-public-ip"
# }

# resource "null_resource" "configure-cat-app" {
#   depends_on = [ncloud_public_ip.hashicat]

#   triggers = {
#     build_number = timestamp()
#   }

#   provisioner "file" {
#     source      = "files/"
#     destination = "/tmp"

#     connection {
#       type     = "ssh"
#       user     = "root"
#       port     = "22"
#       password = data.ncloud_root_password.hashicat.root_password
#       host     = ncloud_public_ip.hashicat.public_ip
#     }
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "sudo apt -y update",
#       "sleep 15",
#       "sudo apt -y update",
#       "sudo apt -y install apache2",
#       "sudo systemctl start apache2",
#       "chmod +x /tmp/*.sh",
#       "PLACEHOLDER=${var.placeholder} WIDTH=${var.width} HEIGHT=${var.height} PREFIX=${var.prefix} /tmp/deploy_app.sh",
#     ]

#     connection {
#       type     = "ssh"
#       user     = "root"
#       port     = "22"
#       password = data.ncloud_root_password.hashicat.root_password
#       host     = ncloud_public_ip.hashicat.public_ip
#     }
#   }
# }

# output "public_ip" {
#   value = ncloud_public_ip.hashicat.public_ip
# }