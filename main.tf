provider "openstack" {
   cloud = var.cloud
}

resource "openstack_images_image_v2" "fedora_core_os" {
  name             = "Fedora-CoreOS-32"
  image_source_url = "https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/32.20200629.3.0/x86_64/fedora-coreos-32.20200629.3.0-openstack.x86_64.qcow2.xz"
  container_format = "bare"
  disk_format      = "qcow2"
}

resource "openstack_networking_network_v2" "network_control" {
  name           = var.network
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet_control" {
  network_id = openstack_networking_network_v2.network_control.id
  name       = var.subnet
  cidr       = "10.0.0.0/24"
}

resource "openstack_networking_router_v2" "router" {
  name                = "tf-cloud-router"
  external_network_id = var.external_network_id
}

resource "openstack_networking_router_interface_v2" "router_iface_private" {
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.subnet_control.id
}

resource "openstack_compute_keypair_v2" "ssh_keypair" {
  name       = "tf-cloud-key"
  public_key = file("${var.ssh_key_file}.pub")
}

resource "openstack_compute_instance_v2" "node_controller" {
  count           = "3"
  name            = "tf-cloud-controller-${count.index}"
  image_id        = openstack_images_image_v2.fedora_core_os.id
  flavor_name     = "m1.xlarge"
  key_pair        = "tf-cloud-key"
  security_groups = ["default"]

  network {
    name = var.network
  }
}

resource "openstack_compute_instance_v2" "node_compute" {
  count           = "2"
  name            = "tf-cloud-compute-${count.index}"
  image_id        = openstack_images_image_v2.fedora_core_os.id
  flavor_name     = "m1.medium"
  key_pair        = "tf-cloud-key"
  security_groups = ["default"]

  network {
    name = var.network
  }
}
