terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.18.0"
    }
  }
}


module "lambdas" {
  source = "./module/lambda" 
}
