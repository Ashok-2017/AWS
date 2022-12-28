data "aws_vpcs" "peer" {
  provider = aws.ashok
  filter {
    name = "cidr"
    values = ["10.35.23.0/21"]
  }
}
data "aws_caller_identity" "peer1" {
  provider = aws.vikram
}

resource "
