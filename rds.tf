resource "aws_db_instance" "my-db" {
  engine                  = "MySQL"
  engine_version          = "5.7.33"
  identifier              = "sample-db"
  name                    = "sample_db"
  username                = "root" #masterユーザー名
  password                = "password"
  instance_class          = "db.t2.micro"
  storage_type            = "gp2" #ec2インスタンスが利用するデフォルトのやつ
  allocated_storage       = 20
  max_allocated_storage   = 1000
  port                    = 3306
  backup_retention_period = 7
  copy_tags_to_snapshot   = true
  skip_final_snapshot     = true
  vpc_security_group_ids  = [aws_security_group.rds-sg.id]
  parameter_group_name    = aws_db_parameter_group.db-pg.name
  db_subnet_group_name    = aws_db_subnet_group.db-sg.name
  availability_zone       = "ap-northeast-1a"
}