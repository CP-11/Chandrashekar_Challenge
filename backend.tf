terraform {
  backend "s3" {
    bucket = "random-state-bucket"
    key    = "challange-webserver"
    region = "us-east-1"
  }
}