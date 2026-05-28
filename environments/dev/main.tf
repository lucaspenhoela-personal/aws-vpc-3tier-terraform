locals {
  name_prefix = "${var.environment}-3tier"
}

# 1️⃣ VPC + Subnets + Routing
module "vpc" {
  source = "../../modules/vpc"

  name_prefix        = local.name_prefix
  vpc_cidr           = var.vpc_cidr
  azs                = var.azs
  enable_nat_gateway = true
}

# 2️⃣ Security Groups (camadas isoladas)
module "security" {
  source = "../../modules/security"

  name_prefix = local.name_prefix
  vpc_id      = module.vpc.vpc_id
}

# 3️⃣ Application Load Balancer (público)
module "alb" {
  source = "../../modules/alb"

  name_prefix       = local.name_prefix
  vpc_id            = module.vpc.vpc_id
  alb_sg_id         = module.security.alb_sg_id
  public_subnet_ids = module.vpc.public_subnet_ids
}

# 4️⃣ RDS MySQL (privado)
module "database" {
  source = "../../modules/database"

  name_prefix           = local.name_prefix
  private_db_subnet_ids = module.vpc.private_db_subnet_ids
  db_sg_id              = module.security.db_sg_id
  db_username           = var.db_username
  db_password           = var.db_password
  db_instance_class     = var.db_instance_class
}

# 5️⃣ EC2 Auto Scaling Group (privado)
module "compute" {
  source = "../../modules/compute"

  name_prefix        = local.name_prefix
  instance_type      = var.instance_type
  app_sg_id          = module.security.app_sg_id
  private_subnet_ids = module.vpc.private_app_subnet_ids
  target_group_arn   = module.alb.target_group_arn
  db_endpoint        = module.database.db_endpoint
}