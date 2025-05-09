# Ресурсы для создания двух web-серверов с Nginx в разных зонах
resource "yandex_compute_instance" "nginx_servers" {
  count        = 2
  name         = "nginx-server-${count.index + 1}"
  hostname     = "nginx-server-${count.index + 1}.ru-central1.internal"
  platform_id  = "standard-v2"
  allow_stopping_for_update = true
  resources {
    cores         = 2
    core_fraction = 5
    memory        = 1
  }
  boot_disk {
    initialize_params {
      image_id = "fd8j0uq7qcvtb65fbffl" 
      size = 10
    }
  }
  network_interface {
  subnet_id = [yandex_vpc_subnet.web_subnet_a.id, yandex_vpc_subnet.web_subnet_b.id][count.index]
  security_group_ids = [yandex_vpc_security_group.web-nginx-sg.id]
    nat       = false
  }
  scheduling_policy {
    preemptible = false
  }

  metadata = {
    ssh-keys  = "ubuntu:${file(var.public_key_path)}"
    user-data = file("/home/pergunovdv/diplom_netology/Terraform/nginx_conf.yaml")
  }

  zone = ["ru-central1-a", "ru-central1-b"][count.index]
}
