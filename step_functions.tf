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

{
  "Comment": "Empty definition",
  "StartAt": "Init",
  "States": {
    "Init": {
      "Type": "Pass",
      "Result": {
        "env": "dev" 
      },
      "ResultPath": "$.Env",
      "Next": "SNF"
    },
    "SNF": {
      "Type": "Task",
      "Resource": "arn:aws:states:::lambda:invoke",
      "Parameters": {
        "FunctionName.$": "States.Format('arn.aws.lambda:$LATEST', $.Env.env)",
        "Payload": {
          "LOCAL_VARS": {
            "1": {
              "name": "NONE"
            }
          },
          "runId.$": "$$.Execution.id",
          "SQL": [
            ""
            ]
        }
      },
      "ResultsPath": "$.results.snfLoad",
      "Next": "Is work day" 
    },
    "Type": "Choice",
    "Choices": [
      {
        "Variable": "$.results.snfLoad.PayLoad.RUN_QUERY_WITH_CHECK",
        "StringEquals": 
      }
      
      data "local_file" "c1" {
        filename = "${path,module}/definitions-${local.Env}/"
      }
      
      data "aws_iam_role" "c2" {
        name = "SfnSynchronousExecutionRole_${local.Env}"
      }
      
      resource "aws_sfn_state_machine" "c3" {
        name = " "
        role_arn = data.aws_iam_role.c2.arn
        definition = data.local_file.content
        
        logging_configuration {
          log_destination = "${aws_cloudwatch_log_group.arn}:*"
          include_execution_data = true
          level = "ERROR"
        }
        tags = local.common_tags
      }
      resource "aws_cloudwatch_log_group" "c5" {
        name = "/aws"
        kms_key_id = aws_kms_key.cloudwatch_key.arn
        tags = local.common_tags
      }
      
      
      
      
      
      
        
        
        
        
