provider "aws" {
  region = "xxxx"
  profile = "ashok"
}
provider "aws" {
  alias = "vikram"
  region = "xxxx"
  profile = "xxxx"
  assume_role {
    role_arn = "arn:aws:iam:xxxx:role/xxxxx"
    session_name = "xxxx"
  }
}
