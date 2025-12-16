variable "project_id" {
  type        = string
  description = "GCP プロジェクト ID (prod 用)"
}

variable "region" {
  type        = string
  description = "GCP リージョン"
  default     = "asia-northeast1"
}

variable "zone" {
  type        = string
  description = "GCP ゾーン"
  default     = "asia-northeast1-b"
}

variable "machine_type" {
  type        = string
  description = "マシンタイプ"
  default     = "e2-medium"
}
