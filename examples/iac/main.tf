provider "aws" {
  region = var.region
  assume_role {
    role_arn = ""
  }
}

# terraform {
#   backend "s3" {}
# }

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {}

locals {
  name   = "my-vpc-01"
  region = "us-east-1"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Example    = local.name
  }
}

module "vpc" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git"
  name = local.name
  cidr = local.vpc_cidr
  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k)]
  tags = local.tags
}

module "complete_sg" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-security-group.git"
  for_each = var.security_groups
  name        = each.value.name
  description = each.value.description
  vpc_id      = each.value.vpc_id
  ingress_with_cidr_blocks = each.value.ingress_with_cidr_blocks
  #egress_rules  = each.value.egress_rules
  tags = {
    Cash       = "king"
    Department = "kingdom"
  }
}


module "ec2_instance" {
    source                   = "git::https://github.com/terraform-aws-modules/terraform-aws-ec2-instance.git"
    for_each = var.ec2_config1
    create                   = each.value.create
    name                     = each.value.name
    ami                      = each.value.ami_linux
    instance_type            = each.value.instance_type_linux
    availability_zone        = each.value.availability_zone_linux
    subnet_id                = each.value.subnet_id_linux
    private_ip               = each.value.private_ip
    vpc_security_group_ids   = each.value.vpc_security_group_ids
    key_name                 = each.value.key_pair_name_linux   
    iam_instance_profile     = each.value.iam_instance_profile_linux
    user_data_replace_on_change = each.value.user_data_replace_on_change_linux
    enable_volume_tags       = each.value.enable_volume_tags_linux
    #metadata_options         = each.value.metadata_options
    #root_block_device_volume_size = each.value.root_block_device_volume_size_01
    ebs_block_device              = each.value.ebs_volumes
    tags                     = each.value.tags
    create_iam_instance_profile = each.value.create_iam_instance_profile
    user_data = file("${path.cwd}/user_data_templates/${each.value.user_data_file_name_linux}")
}
