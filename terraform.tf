 terraform {
    backend "gcs" {
        bucket  = "week4-terraform-bucket"
        prefix  = "terraform/state"
        credentials = "/home/terraform/infrastructure/credentials.json"
   }
}
