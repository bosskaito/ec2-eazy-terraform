resource "aws_db_instance" "default" {
  # 割り当てるストレージのサイズ(GB)
  allocated_storage = 20
  # 汎用 SSD を使用する
  storage_type = "gp2"
  # 今回は「MySQL 8.0」を利用する。
  engine = "mysql"
  engine_version = "8.0"
  # インスタンスクラスを設定する。
  instance_class = "db.t2.micro"
  db_subnet_group_name = aws_db_subnet_group.default.id
  vpc_security_group_ids  = [ aws_security_group.db_instance.id ]
  parameter_group_name = aws_db_parameter_group.default.id
  name = var.db_name
  username = var.db_username
  password = var.db_password
  skip_final_snapshot = true
  tags = { Name = "${var.app}-rds" }
}