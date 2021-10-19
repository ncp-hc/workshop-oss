terraform {
  required_providers {
    ncloud = {
      source = "NaverCloudPlatform/ncloud"
      version = ">= 2.1.2"
    }
  }
}

provider "ncloud" {
  # Configuration options
}

resource "ncloud_vpc" "vpc" {
 ipv4_cidr_block = "10.0.0.0/16"
}