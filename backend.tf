terraform {
  backend "s3" {
    bucket  = "projectstatefile"
    key     = "week10/terraformstatefile.tf"
    encrypt = true
    region  = "us-east-1"
    #dynamodb_table = "value"
  }
}
