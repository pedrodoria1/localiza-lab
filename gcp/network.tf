resource "google_compute_network" "vpc_network" {
  project                 = "localiza-329913"
  name                    = "vpc-localiza-lab"
  auto_create_subnetworks = true
  mtu                     = 1460
}