data "aws_iam_policy_document" "policy" {
  policy_id = "policy-for-staging"
  
  statement {
    sid = "AllowSESPuts" 
    effect = "Allow"
    principals {
      type = "Service" 
      identifiers = ["ses.amazonaws.com"]
    }
    actions = ["s3:PutObject"]
    resources = ["arn:aws:s3:::/*"]
    condition {
      test = "StringEquals"
      variable = "aws:Referer"
      values = []
    }
  }
  statement {
    sid = "DenyUnsecureCommunications"
    effect = "Deny"
    actions = ["s3:*"]
    resources = [ "arn:aws:s3:::/", "arn:aws:s3:::/*"]
    principals {
      type = "*"
      identifiers = ["*"]
    }
    condition {
      test = "Bool"
      variable = "aws:SecureTransport"
      values = [ "false" ]
    }
  }
}
