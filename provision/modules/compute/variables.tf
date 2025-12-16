variable "name" {
  type        = string
  description = "インスタンス名"
}

variable "machine_type" {
  type        = string
  description = "マシンタイプ (例: e2-micro)"
  default     = "e2-micro"
}

variable "zone" {
  type        = string
  description = "配置するゾーン (例: asia-northeast1-b)"
}

variable "image" {
  type        = string
  description = "ブートディスクのイメージ"
  default     = "debian-cloud/debian-12"
}

variable "network" {
  type        = string
  description = "接続する VPC ネットワーク self_link または name"
  default     = "default"
}

variable "labels" {
  type        = map(string)
  description = "任意のラベル"
  default     = {}
}
