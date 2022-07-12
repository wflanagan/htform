variable "hcloud_token" {
}

variable "location" {
  default="fsn1"
}

variable "http_protocol" {
  default="http"
}

variable "http_port" {
  default="80"
}

variable "instances" {
  default="1"
}

variable "server_type" {
  default="cx11"
}

variable "os_type" {
  default="ubuntu-20.04"
}

variable "disk_size" {
  default="20"
} 

variable "ip_range" {
  default="10.0.1.0/24"
}