resource "aws_glue_catalog_database" "s3" {
  name = "s3-inventory"
  description = " database "
}

resource "aws_glue_crawler" "crawler" {
  database_name = aws_glue_catalog_database.s3.name
  name = "s3"
  role = var.glue_role
  
  s3_target {
    path = var.s3_inventory_path
  }
  
  schedule = "cron(0 0 ? * MON *)"
  
  
  
