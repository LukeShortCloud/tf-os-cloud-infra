variable "cloud" {
  type    = string
  default = "upshift-df"
}

variable "network" {
  type    = string
  default = "ekultails-network-control"
}

variable "subnet" {
  type    = string
  default = "ekultails-subnet-control"
}

variable "external_network_id" {
  type    = string
  default = "6a32627e-d98d-40d8-9324-5da7cf1452fc"
}

variable "external_network_name" {
  type    = string
  default = "provider_net_shared"
}

variable "ssh_key_file" {
  type    = string
  default = "~/.ssh/id_rsa"
}
