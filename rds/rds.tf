#tfsec:ignore:aws-cloudwatch-log-group-customer-key
resource "aws_rds_cluster" "serverless_wordpress" {

  database_name                       = "wordpress"
  engine                              = "aurora-mysql"
  engine_version                      = "5.7.mysql_aurora.2.07.1"
  engine_mode                         = "serverless"

  vpc_security_group_ids              = [aws_security_group.aurora_serverless_group.id]
  db_subnet_group_name                = aws_db_subnet_group.main_vpc.name
  cluster_identifier                  = "${var.site_name}-serverless-wordpress"
  engine                              = "aurora-mysql"
  engine_version                      = "5.7.mysql_aurora.2.07.1"
  engine_mode                         = "serverless"
  database_name                       = "wordpress"
  master_username                     = "wp_master"
  enable_http_endpoint                = true
  iam_database_authentication_enabled = false
  master_password                     = random_password.serverless_wordpress_password.result
  backup_retention_period             = 5
  storage_encrypted                   = true
  scaling_configuration {
    auto_pause               = true
    max_capacity             = 1
    min_capacity             = 1
    seconds_until_auto_pause = 300
    timeout_action           = "ForceApplyCapacityChange"
  }
  skip_final_snapshot       = false
  final_snapshot_identifier = "${var.site_name}-serverless-wordpress-${random_id.rds_snapshot.dec}"
  snapshot_identifier       = var.snapshot_identifier
  depends_on                = [aws_cloudwatch_log_group.serverless_wordpress]
}
