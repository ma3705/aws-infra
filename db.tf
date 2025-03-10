resource "aws_db_instance" "wordpress" {
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t3.micro"
  db_name                 = "wpdb"
  username                = "dba"
  password                = random_password.wordpress.result
  parameter_group_name    = "default.mysql5.7"
  multi_az                = false
  db_subnet_group_name    = aws_db_subnet_group.db.name
  vpc_security_group_ids  = [aws_security_group.db.id]
  backup_retention_period = "7"
  backup_window           = "01:00-02:00"
  skip_final_snapshot     = true
  max_allocated_storage   = 200
  identifier              = "wordpress"

  tags = {
    Name = "WordPress DB"
  }
}

resource "aws_db_subnet_group" "db" {
  name = "wordpress"
  subnet_ids = [
    aws_subnet.private_a.id,
    aws_subnet.private_c.id
  ]

  tags = {
    Name = "DB subnet group 1"
  }
}

resource "random_password" "wordpress" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}