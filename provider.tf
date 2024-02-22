/*****************************************
 Initializing of terraform providers
*****************************************/

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.11.0"
    }
  }
}

//Configure the AWS Provider
provider "aws" {
  region = var.aws_region
  access_key = var.aws_access_key  #generally not recomended way shown just for example
  secret_key = var.aws_secret_key

}
