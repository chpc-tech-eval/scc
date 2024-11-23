provider "openstack" {
  cloud = "openstack"
}
resource "openstack_compute_instance_v2" "terraform-demo-instance" {
  name = "de3rdCompute"
  image_id = "97991be4-1df0-4502-9370-55e9b624592e"
  flavor_id = "35617c38-b1ce-4d49-894e-74ce7ddcdc26"
  key_pair = "deKeyProject"
  security_groups = ["default", "scc24_sg"]

  network {
    name = "wits1-vxlan"
  }
}
