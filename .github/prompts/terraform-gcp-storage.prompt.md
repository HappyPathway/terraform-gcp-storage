# Data & Storage Module

## Overview
This module provisions Cloud SQL for PostgreSQL and Cloud Storage for Terraform module uploads.

## Resources Created
- **Cloud SQL (PostgreSQL)**
- **Cloud Storage Bucket**
- **IAM Permissions for Secure Access**
- **Backup & PITR Configurations**

## Inputs
- `project_id` - GCP Project ID
- `region` - Deployment region
- `db_instance_name` - Name of the Cloud SQL instance
- `db_tier` - Machine type for Cloud SQL
- `storage_bucket_name` - Name of the storage bucket

## Outputs
- `db_instance_connection_name` - Connection name for Cloud SQL
- `storage_bucket_url` - URL of the storage bucket

## Usage Example
```hcl
module "storage" {
  source               = "./modules/storage"
  project_id           = "my-gcp-project"
  region               = "us-central1"
  db_instance_name     = "terraform-db"
  db_tier              = "db-custom-1-3840"
  storage_bucket_name  = "terraform-modules-bucket"
}
```

## Best Practices
- Use **Cloud SQL Auth Proxy** instead of public IP access.
- Enable **Automated Backups & PITR**.
- Set appropriate IAM roles for bucket access.