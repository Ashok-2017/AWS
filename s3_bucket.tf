resource "aws_s3_bucket" "test" {
  bucket = var.bucket_name
  acl = "private"
  
  versioning {
    enabled = var.versioned
  }
  lifecycle_rule {
    enabled = var.lifecycle_rule["enabled"]
    expiration {
      days = var.lifecycle_rule["expiration_days"]
    }
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_policy" "bucket1" {
  bucket = aws_s3_bucket.test.id
  policy = templatefile("ssl.json", { bucket_arn = aws_s3_bucket.test.arn})
}

output "s3_bucket_id" {
  value = aws_s3_bucket.test.id 
}
output "s3_bucket_arn" {
  value = aws_s3_bucket.test.arn
}
resource "aws_s3_bucket_public_access_block" "test3" {
  count = 4
  bucket = var.bucket_name
  
  block_public_acls = true
  ignore_public_acls = true
  block_public_policy = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "test8" {
  bucket = aws_s3_bucket.test8.id
  policy = templatefile("${path.module}")
  {
    principals = jsonencode(local.est),
    region = "xxxx"
    env = "staging"
  }
}

data "aws_iam_policy_document" "access_data" {
  statement {
     sid = "LoadBalancerAllowWrite"
     actions = ["s3:PutObject"]
     resources = [ ]
     principals {
        identifiers = [ ]
        type = "AWS"
     }
  }
}

resource "aws_s3_bucket" "access_data" {
  bucket = " "
  acl = "log-delivery-write"
  policy = data.aws_iam_policy_document.access_data.json
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  versioning {
    enabled = true
  }
  tags = {
    environment = local.Environment
  }
}

data "aws_sqs_queue" "file" {
  name = " "
}

resource "aws_s3_bucket_notification" "f1" {
  bucket = aws_s3_bucket.access_data.id
  queue {
    queue_arn = data.aws_sqs_queue.file.arn
    events = ["s3:ObjectCreated:*"]
    filter_prefix = " /"
    filter_suffix = ".pdf"
  }
} 
    
  
 







