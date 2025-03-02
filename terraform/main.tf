/*This block defines the required provider for Terraform.
It specifies that we are using the Google Cloud provider (hashicorp/google).
The version = "~> 5.0" ensures we use Terraform provider version 5.x (but not 6.x).
*/
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}
/*
This block configures the Google Cloud provider with your project and authentication details.
project → Your GCP project ID (replace it with your actual project ID).
region → The default region where resources will be created.
credentials → Path to your Service Account JSON key file for authentication.
🔹 Note: If you have already authenticated using gcloud auth application-default login, you can omit the credentials argument.
*/

provider "google" {
  project     = "cogent-anvil-452514-r6"
  region      = "us-central1"
  credentials = file("/home/chetannk1996/terraform-gcs/cogent-anvil-452514-r6-7ac59e98563c.json")
}
/*
This block creates a GCS bucket in Google Cloud.
name → A unique name for your bucket (must be globally unique).
location → The region where the bucket will be created (US means multi-region in the US).
storage_class → Defines the storage type (STANDARD, NEARLINE, COLDLINE, or ARCHIVE).
*/

resource "google_storage_bucket" "source_bucket" {
  name          = "igreen-data-dev-source-bucket"
  location      = "us-central1"
  storage_class = "STANDARD"

#This enables object versioning, so deleted or overwritten files can be recovered.
  versioning {
    enabled = true
  }
#This block adds a lifecycle policy to delete objects older than 30 days automatically.
  lifecycle_rule {
    condition {
      age = 30
    }
    action {
      type = "Delete"
    }
  }
}

