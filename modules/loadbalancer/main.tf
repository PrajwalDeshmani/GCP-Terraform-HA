resource "google_compute_health_check" "http" {
  name = "http-health-check"

  http_health_check {
    port = 80
  }
}

resource "google_compute_backend_service" "default" {
  name          = "backend-service"
  protocol      = "HTTP"
  timeout_sec   = 10
  health_checks = [google_compute_health_check.http.id]

  backend {
    group = var.instance_group_1
  }

  backend {
    group = var.instance_group_2
  }
}

resource "google_compute_url_map" "urlmap" {
  name            = "url-map"
  default_service = google_compute_backend_service.default.id
}

resource "google_compute_target_http_proxy" "proxy" {
  name    = "http-proxy"
  url_map = google_compute_url_map.urlmap.id
}

resource "google_compute_global_forwarding_rule" "forwarding_rule" {
  name       = "http-forwarding-rule"
  target     = google_compute_target_http_proxy.proxy.id
  port_range = "80"
}
