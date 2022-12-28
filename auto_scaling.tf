resource "aws_appautoscaling_target" "db" {
  max_capacity = 40
  min_capacity = 10
  resource_id = "table/msg_processing"
  scalable_dimension = "dynamodb:table:WriteCapacityUnits"
  service_namespace =  " 
