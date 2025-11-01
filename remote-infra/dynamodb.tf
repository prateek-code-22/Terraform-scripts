resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "dynamodb-table-1644"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "dynamodb-table-1644"
  }
}