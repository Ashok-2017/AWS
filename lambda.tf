resource "aws_lambda_permission" "external" {
  statement_id = "AllowExecutionFromS3bucket${local.Env}}
  action = "lambda: Invokefunction" 
  function_name = data.aws_lambda_function
  principal = "s3.amazonaws.com"
  source_arn = 
} 

resource "aws_lambda_permission" "allow" {
  
  
