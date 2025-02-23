terraform {
  required_version = ">= 1.0.0"
}

# Cloud Storage for Terraform module storage
module "gcs_buckets" {
  source     = "terraform-google-modules/cloud-storage/google"
  version    = "~> 3.4"
  project_id = var.project_id
  names      = ["${var.project_id}-modules"]
  prefix     = ""
  versioning = {
    "${var.project_id}-modules" = true
  }
}

# Cloud SQL instance
module "postgresql" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/postgresql"
  version = "~> 13.0"

  name             = "${var.project_id}-db"
  project_id       = var.project_id
  database_version = "POSTGRES_14"
  region           = var.region
  zone             = "${var.region}-a"
  tier             = "db-custom-2-4096"

  deletion_protection = true

  backup_configuration = {
    enabled                        = true
    point_in_time_recovery_enabled = true
    start_time                     = "02:00"
    location                       = "us"
    retained_backups               = 7
    retention_unit                 = "COUNT"
  }

  ip_configuration = {
    ipv4_enabled        = false
    private_network     = data.terraform_remote_state.networking.outputs.vpc_network_name
    require_ssl         = true
    allocated_ip_range  = null
    authorized_networks = []
  }
}

# Cloud SQL database
resource "google_sql_database" "database" {
  name     = "app-database"
  instance = module.postgresql.instance_name
}

data "terraform_remote_state" "networking" {
  backend = "gcs"
  config = {
    bucket = "tf-state-gcp-kubernetes"
    prefix = "terraform/state/networking"
  }
}
