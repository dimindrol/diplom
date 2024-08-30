resource "yandex_compute_snapshot_schedule" "VM-Snapshots" {
  name = "VM-Snapshots"

  schedule_policy {
    expression = "0 0 ? * *"
  }

  snapshot_count = 2

  snapshot_spec {
    description = "VM-Snapshots"  
  }

  disk_ids = [yandex_compute_instance.nginx_servers[0].boot_disk[0].disk_id,
  yandex_compute_instance.nginx_servers[1].boot_disk[0].disk_id,
  yandex_compute_instance.bastion.boot_disk[0].disk_id,
  yandex_compute_instance.elastic.boot_disk[0].disk_id,
  yandex_compute_instance.kibana.boot_disk[0].disk_id,
  yandex_compute_instance.zabbix.boot_disk[0].disk_id,
  ]
}