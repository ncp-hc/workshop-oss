##############################################################################
# Variables File
#
# Here is where we store the default values for all the variables used in our
# Terraform code. If you create a variable with no default, the user will be
# prompted to enter it (or define it via config file or command line flags.)

variable "prefix" {
  description = "This prefix will be included in the name of most resources."
}

variable "region" {
  description = "The region where the resources are created."
  default     = "KR"
}

variable "site" {
  description = "Ncloud site. By default, the value is public. You can specify only the following value: public, gov, fin. public is for www.ncloud.com. gov is for www.gov-ncloud.com. fin is for www.fin-ncloud.com."
  default     = "public"
}

variable "address_space" {
  description = "The address space that is used by the virtual network. You can supply more than one address space. Changing this forces a new resource to be created."
  default     = "10.0.0.0/16"
}