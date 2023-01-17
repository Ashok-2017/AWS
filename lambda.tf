resource "aws_lambda_permission" "external" {
  statement_id = "AllowExecutionFromS3bucket${local.Env}"
  action = "lambda: Invokefunction" 
  function_name = data.aws_lambda_function
  principal = "s3.amazonaws.com"
  source_arn = 
} 

resource "aws_lambda_permission" "allow" {
  statement_id = "AllowExecutionFromS3BucketExport${local.Env}"
  action = "lambda: Invokefunction"
  function_name = data.aws_lambda_function.function_name
  principal = "s3.amazonaws.com"
  source_arn = 
}

resource "aws_s3_bucket_notification" "pr" {
  bucket = 
  lambda_function {
    id = " "
    lambda_function_arn = 
    events = ["s3:ObjectCreated:*"]
    filter_prefix = " "
    depends_on = [
      aws_lambda_person.
  
   ]
  }
  
  resource "aws_lambda_permission" "bucket" {
    statement_id = "AllowExecutionFromS3Bucket-${local.Env}"
    action = "lambda: InvokeFunction"
    function_name = data.aws_lambda_function.function_name
    principal = "s3.amazonaws.com"
    source_arn = data.aws_s3_bucket.arn
  }
  resource "aws_s3_bucket_notification" "notif" {
    bucket = 
    lambda_function {
      lambda_function_arn = data.aws_lambda_function.arn
      events = ["s3:ObjectCreated:*"]
      filter_prefix = " "
    }
    
    depends_on = [aws_lambda_permission. ]
  }  
    
    
  
  
  



  
  
