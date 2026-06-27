terraform {
  backend "s3" {
    bucket  = "mystatetestfile"
    key     = "dev/terraform.tfstate"
    region  = "us-east-1"
    profile = "harips"
    encrypt = true
    #dynamodb_table = "terraform-lock-table"
  }
}
/*resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
*/