terraform {
  

#STEP2: DEFINE THE REGION (N. Virginia)

 backend "s3" {
    bucket         = "demo-terraform-eks-state-s3-bucket-eu-north-1"
    key            = "terraform.tfstate"
    region         = "eu-north-1"
   # dynamodb_table = "terraform-eks-state-locks"
    encrypt        = true
  }
}
