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

variable "nodejs_version" {
  type = string
  default = "15.14.0"
}

variable "ruby_version" {
  type = string
  default = "3.0.3"
}

variable "script_loc" {
  type = string
  default = "/tmp"
}

variable "compute_user" {
  type = string
  default = "root"
}

variable "asdf_git_repo_url" {
  type= string
  default = "https://github.com/asdf-vm/asdf.git"
}

variable "asdf_nodejs_git_repo_url" {
  type= string
  default = "https://github.com/asdf-vm/asdf-nodejs.git"
}

variable "asdf_ruby_git_repo_url" {
  type= string
  default = "https://github.com/asdf-vm/asdf-ruby.git"
}

variable "hetzner_private_key_path" {
  type = string
}

