variable "YC_TOKEN" {
  description = "Yandex Cloud TOKEN"
  type        = string
  sensitive   = true
}

variable "YC_CLOUD_ID" {
  description = "Yandex Cloud ID"
  type        = string
  sensitive   = true
}

variable "YC_FOLDER_ID" {
  description = "Yandex Cloud Folder"
  type        = string
  sensitive   = true
}

variable "public_key_path" {
  description = "Path to public key file"
  type        = string
  default = "/home/pergunovdv/.ssh/authorized_keys"
}

variable "zone" {
  description = "Yandex Cloud zone"
  type        = string
  default = "ru-central1-a"
}
