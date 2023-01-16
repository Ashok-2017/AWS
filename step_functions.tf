resource "aws_iam_role" "t1" {
  name = " "
  assume_role_policy = file("${path.module}/policies/assume_role.json")
}

resource "aws_sfn_state_machine" "testing1" {
  name = "  "
  role_arn = 
  definition = " "
  logging_configuration {
    log_destination = " "
    include_execution_data = true
    level = "ERROR"
  }
  tags = local.common_tags
}
