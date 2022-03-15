resource "aws_db_parameter_group" "default" {
  name_prefix = var.app
  family = "mysql8.0"
  description = "${var.app} parameter group for mysql8.0"
  parameter {
    name = "time_zone"
    value = "Asia/Tokyo"
  }
  tags = { Name = var.app }
}