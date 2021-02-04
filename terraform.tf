 terraform {
    backend "gcs" {
        bucket  = "week4-terraform-bucket"
        prefix  = "terraform/state"
        credentials = "/var/lib/jenkins/credentials.json"
   }
}
