terraform {
  required_version = ">= 1.6.0"

  backend "s3" {
    bucket         = "meu-tfstate-vpc3tier-1779970192" # SEU BUCKET
    key            = "dev/vpc-3tier/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}