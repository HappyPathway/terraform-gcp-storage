variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region for resource deployment"
  type        = string
}

output "gcs_bucket_name" {
  value = module.gcs_buckets.bucket.name
}

output "postgresql_instance_name" {
  value = module.postgresql.instance_name
}

output "postgresql_connection_name" {
  value = module.postgresql.instance_connection_name
}
