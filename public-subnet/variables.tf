######################################################################
# All Variables must be set here, in terraform.tfvars, or on the
# command line.
###

######################################################################
# AWS Variables
###
variable "aws_access_key"     { }
variable "aws_secret_key"     { }

######################################################################
# Tags
###
variable "subnet_name_tag" {}
variable "owner_tag" {}
variable "business_unit_tag" {}
variable "environment_tag" {}
variable "security_tag" {}
variable "sub_application_id_tag" {}
variable "sub_application_role_tag" {}
variable "financial_tag" {}
variable "automation_tag" {}

######################################################################
# Network config settings
##
variable "vpc_id"         {}
variable "vpc_cidr"         {}
variable "azs"    {}
variable "public_subnets"         {}
variable "public_route_table_id" {}
variable "map_public_ip_on_launch" {
	default = "false"
}
