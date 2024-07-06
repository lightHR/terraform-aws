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

module "database" {
  source = "./database"
  db_storage = 10
  db_engin_version = "5.7.22"
  db_instance_class = "db.t2.micro"
  dbname = "rancher"
  dbuser = "bobby"
  dbpassword = "Aw-12@12"
  db_identifier = "mtc-db"
  skip_db_snapshot = true
  db_subner_groupname = ""
  vpc_sercurity_group_ids =[]
}