
terraform{
    backend "s3" {
        bucket         	   = "cloudjerry-terraform-state-bucket"
        key              	   = "state/terraform.tfstate"
        region         	   = "ap-south-1"
        encrypt        	   = true
        dynamodb_table = "cloudjerry-tf-state-table"
    }
}