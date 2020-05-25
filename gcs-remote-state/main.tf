provider "google" {
  version = "3.5.0"

  credentials = file("/Users/levep/local-Documents/tmp/devops-cloud-275818-463e911b2d65.json")

  project = "devops-cloud-275818"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_storage_bucket" "terraform_state" {
    name = "terraform-state-275818"
    location = "us-central1"

    versioning {
        enabled = true
    } 


}