# --- root/main.tf ---

module "networking-vpc" {
  source           = "./networking-vpc"
  security_groups  = local.security_groups
  vpc_cidr         = local.vpc_cidr
  access_ip        = var.access_ip
  public_sn_count  = 2
  private_sn_count = 3
  max_subnets      = 20
  public_cidrs     = [for i in range(2, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
  private_cidrs    = [for i in range(1, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
  db_subnet_group  = true
}

# module "database" {
#   source                 = "./database"
#   db_storage             = 10
#   db_engine_version      = "5.7.44"
#   db_instance_class      = "db.t3.micro"
#   dbname                 = var.dbname
#   dbuser                 = var.dbuser
#   dbpassword             = var.dbpassword
#   db_identifier          = "mtc-db"
#   skip_db_snapshot       = true
#   db_subnet_group_name   = module.networking-vpc.db_subnet_group_name[0]
#   vpc_security_group_ids = module.networking-vpc.db_security_group
# }

module "loadbalancing" {
  source                  = "./loadbalancing"
  public_sg               = module.networking-vpc.public_sg
  public_subnets          = module.networking-vpc.public_subnets
  tg_port                 = 80
  tg_protocol             = "HTTP"
  vpc_id                  = module.networking-vpc.vpc_id
  lb_healthy_threshold    = 2
  lb_unhealthy_thresshold = 2
  lb_timeout              = 3
  lb_interval             = 30
  listener_port           = 80
  listener_protocol       = "HTTP"
}
