# allow access from health check ranges
resource "google_compute_firewall" "allow-lb-hc" {
  name          = "l7-xlb-fw-allow-hc"
  provider      = google
  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.id
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  allow {
    protocol = "tcp"
  }
  target_tags = ["allow-health-check"]
}