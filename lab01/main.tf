terraform {
  required_providers {
    ncloud = {
      source  = "NaverCloudPlatform/ncloud"
      version = ">= 2.1.2"
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

