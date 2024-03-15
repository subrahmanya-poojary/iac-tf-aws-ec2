default_tags = {
  Name = "my-server"
  Env  = "Dev"
  Data = "public"
}

accont_no  = "123"
admin_role = "test-role"
env        = "dev"
region = "us-east-1"

ec2_config1 = {
  dev-ec2-01 = {
    create                      = true
    name                        = "dev-ec2-01"
    ami_linux                   = ""
    instance_type_linux         = "t2.small"     
    private_ip                  = ""
    availability_zone_linux     = "us-east-1a"
    subnet_id_linux             = "subnet-"
    vpc_security_group_ids      = ["sg-123"]
    key_pair_name_linux         = ""
    iam_instance_profile_linux  = ""
    user_data_replace_on_change_linux = false
    enable_volume_tags_linux    = true
    root_block_device_volume_size_01 = 80
    create_iam_instance_profile = true
    iam_instance_profile        = "instance-role"
    user_data_file_name_linux   = "userdata-01.txt"
    tags    = {
        Ansible = "yes"
    }
    iam_role_description        = "IAM role for ec2"
    ebs_volumes = [{
        device_name = "/dev/xvda"
        volume_size = 100
        volume_type = "gp3"
        kms_key_id  = ""
        throughput  = 125
    }]
  }
}

security_groups = {
  my-sg-01 = {
     name   = "my-sg-01"
     description = "ec2 sg group"
     vpc_id      = ""
     ingress_with_cidr_blocks = [
        {
            from_port   = 10
            to_port     = 20
            protocol    = 6
            description = "Service name"
            cidr_blocks = "10.10.0.0/20"
        }
    ]
  }
}