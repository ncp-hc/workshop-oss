##############################################################################
# Variables File
#
# Here is where we store the default values for all the variables used in our
# Terraform code. If you create a variable with no default, the user will be
# prompted to enter it (or define it via config file or command line flags.)

variable "prefix" {
  description = "This prefix will be included in the name of most resources."
}

variable "client_ip" {
  description = "https://search.naver.com/search.naver?where=nexearch&sm=top_sug.pre&fbm=1&acr=1&acq=ip&qdt=0&ie=utf8&query=ip+%EC%A3%BC%EC%86%8C+%ED%99%95%EC%9D%B8"
  default = "118.130.103.106"
}

variable "region" {
  description = "The region where the resources are created."
  default     = "KR"
}

variable "zone" {
  description = "The zone where the resources are created."
  default     = "KR-2"
}

variable "site" {
  description = "Ncloud site. By default, the value is public. You can specify only the following value: public, gov, fin. public is for www.ncloud.com. gov is for www.gov-ncloud.com. fin is for www.fin-ncloud.com."
  default     = "public"
}

variable "address_space" {
  description = "The address space that is used by the virtual network. You can supply more than one address space. Changing this forces a new resource to be created."
  default     = "10.0.0.0/16"
}

variable "height" {
  default     = "400"
  description = "Image height in pixels."
}

variable "width" {
  default     = "600"
  description = "Image width in pixels."
}

variable "placeholder" {
  default     = "placekitten.com"
  description = "Image-as-a-service URL. Some other fun ones to try are fillmurray.com, placecage.com, placebeard.it, loremflickr.com, baconmockup.com, placeimg.com, placebear.com, placeskull.com, stevensegallery.com, placedog.net"
}