 terraform {
    backend "gcs" {
        bucket  = "week4-bucket"
        prefix  = "terraform/state"
        credentials = "./gcp-terraform.json"
  }
}
