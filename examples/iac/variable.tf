variable "default_tags" {
    type = map(string)
    description = "Map od mandatory tags"
}

##### Accont Details #####

variable "accont_no" {
  type = string
}
variable "admin_role" {
  type = string 
}
variable "region" {
  type = string
}
variable "env" {
  type = string
}

### Ec2 Server Variables ###
variable "ec2_config1" {
  type = map(object({
    create = bool,
    name                        = string,
    ami_linux                   = string,
    instance_type_linux         = string,     
    private_ip                  = string,
    availability_zone_linux     = string,
    subnet_id_linux             = string,
    vpc_security_group_ids      = list(string),
    key_pair_name_linux         = string,
    iam_instance_profile_linux  = string,
    user_data_replace_on_change_linux = bool,
    enable_volume_tags_linux    = bool
    root_block_device_volume_size_01 = number,
    create_iam_instance_profile = bool,
    iam_instance_profile        = string
    tags                        = map(string),
    iam_role_description        = string,
    ebs_volumes = list(object({
        device_name = string,
        volume_size = number,
        volume_type = string,
        kms_key_id  = string,
        throughput  = number
    })),
    user_data_file_name_linux = string 
  }))
}

variable "security_groups" {
  type = map(any)
}

