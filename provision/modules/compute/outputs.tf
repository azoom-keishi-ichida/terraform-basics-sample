output "instance_name" {
  description = "作成されたインスタンス名"
  value       = google_compute_instance.server.name
}

output "instance_nat_ip" {
  description = "作成されたインスタンスの外部IP (付与している場合)"
  value       = try(google_compute_instance.server.network_interface[0].access_config[0].nat_ip, "")
}
