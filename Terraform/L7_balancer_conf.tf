resource "yandex_alb_target_group" "nginx-target-group" {
  name           = "nginx-target-group"

  target {
    subnet_id    = yandex_vpc_subnet.web_subnet_a.id
    ip_address   = yandex_compute_instance.nginx_servers[0].network_interface.0.ip_address
  }

  target {
    subnet_id    = yandex_vpc_subnet.web_subnet_b.id
    ip_address   = yandex_compute_instance.nginx_servers[1].network_interface.0.ip_address
  }

}

resource "yandex_alb_backend_group" "nginx-backend-group" {
    name                     = "nginx-backend-group"

  http_backend {
    name                   = "nginx-backend-group-http"
    weight                 = 1
    port                   = 80
    target_group_ids       = [yandex_alb_target_group.nginx-target-group.id]
    load_balancing_config {
      panic_threshold      = 90
    }    
    healthcheck {
      timeout              = "5s"
      interval             = "5s"
      healthy_threshold    = 5
      unhealthy_threshold  = 5
      http_healthcheck {
        path               = "/"
      }
    }
  }
}

resource "yandex_alb_http_router" "nginx-tf-router" {
  name          = "nginx-tf-router"
}

resource "yandex_alb_virtual_host" "nginx_virtual_host" {
  name                    = "nginx-virtual-host"
  http_router_id          = yandex_alb_http_router.nginx-tf-router.id
  route {
    name                  = "nginx-http-route"
    http_route {
      http_route_action {
        backend_group_id  = yandex_alb_backend_group.nginx-backend-group.id
        timeout           = "60s"
      }
    }
  }

}


resource "yandex_alb_load_balancer" "l7-balancer" {
  name        = "l7-balancer"
  network_id  = yandex_vpc_network.my_vpc.id

  allocation_policy {
    location {
      zone_id   = var.zone
      subnet_id = yandex_vpc_subnet.public_subnet.id
      
    }
  }

  listener {
    name = "listener"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [ 80 ]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.nginx-tf-router.id
      }
    }
  }

}