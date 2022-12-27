resource "aws_dynamodb_table" "test1" {
  name = "test1"
  billing_mode = "PROVISIONED"
  read_capacity = 30
  write_capacity = 30
  hash_key = "t2"
  attribute {
    name = "t3"
    type = "A"
  }
  point_in_time_recovery {
    enabled = true
  }
  tags = {
    environment = "staging"
  }
}
    
