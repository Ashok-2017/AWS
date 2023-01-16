
resource "aws_kms_key" "sns_topics" {
  description = " testing"
  tags = {
    "environment" = "production"
  }
  policy = file("./kms_key.json")
  enable_key_rotation = true
}

resource "aws_kms_alias" "sns" {
  target_key_id = aws_kms_key.sns_topics.key_id
}

resource "aws_sns_topic" "t1" {
  name = var.name
  display = var.display_name
  kms_master_key_id = var.kms_key_id
  tags = {
    "environment" = var.environment
  }
  
  resource "aws_sns_topic" "fail" {
    for_each = local.environments
    display_name = "failed_${each.key}"
    tags = { 
      "environment" = each.value" 
      }
  }
  
  resource "aws_sns_topic_subscription" "email-1" {
    for_each = local.environments
    topic_arn = 
    protocol = "email"
    endpoint = "ashokrdy51@gmail.com"
  }  
  
