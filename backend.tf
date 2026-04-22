terraform {
  backend "gcs" {
    bucket  = "my-terraform-state-bucket"
    prefix  = "multi-region-ha"
  }
}
