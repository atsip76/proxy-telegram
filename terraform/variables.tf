variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable "instance_ssh_username" {
  default     = "root"
}
variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable instance_ssh_pub_key {
  description = "Public key used for ssh access"
}

variable disk_image {
  description = "Disk image"
}

variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}

variable private_key_path {
  description = "Path to the private_key used for ssh access"
}

variable count_instance {
  description = "count of instances"
  default     = "1"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "docker-base"
}

variable machine_type {
  description = "machine tupe"
  default     = "g1-small"
}

#задаем количество создаваемых инстансов
variable proxy_count {
  default = 1
}
