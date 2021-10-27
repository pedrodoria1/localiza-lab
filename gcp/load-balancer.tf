# reserved IP address
resource "google_compute_global_address" "default" {
  name = "ipaddr-https-lb-external"
}

# forwarding rule
resource "google_compute_global_forwarding_rule" "default" {
  name                  = "forwarding-rule-https-lb-external"
  provider              = google
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "80"
  target                = google_compute_target_http_proxy.default.id
  ip_address            = google_compute_global_address.default.id
}

# http proxy
resource "google_compute_target_http_proxy" "default" {
  name     = "target-http-proxy-https-lb-external"
  provider = google
  url_map  = google_compute_url_map.default.id
}

# url map
resource "google_compute_url_map" "default" {
  name            = "l7-xlb-url-map"
  provider        = google
  default_service = google_compute_backend_service.default.id
}

# backend service with custom request and response headers
resource "google_compute_backend_service" "default" {
  name                     = "backend-service-https-lb-external"
  provider                 = google-beta
  protocol                 = "HTTP"
  port_name                = "port-http"
  load_balancing_scheme    = "EXTERNAL"
  timeout_sec              = 10
  enable_cdn               = true
  health_checks            = [google_compute_health_check.default.id]
  backend {
    group           = google_compute_instance_group_manager.appserver.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}

# health check
resource "google_compute_health_check" "default" {
  name     = "l7-xlb-hc"
  provider = google
  http_health_check {
    port_specification = "USE_SERVING_PORT"
  }
}