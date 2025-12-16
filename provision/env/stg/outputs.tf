output "instance_name" {
  value       = module.web_server.instance_name
  description = "作成されたインスタンス名"
}

output "instance_nat_ip" {
  value       = module.web_server.instance_nat_ip
  description = "作成されたインスタンスの外部IP"
}
