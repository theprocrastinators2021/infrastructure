 terraform {
    backend "gcs" {
        bucket  = "week4-terraform-bucket"
        prefix  = "terraform/state"
        credentials = "./credentials.json"
   }
}
