
#VPC
variable "vpc_name_tag" {}
variable "vpc_application_id_tag" {}
variable "vpc_application_role_tag" {}

#Internet gateway
variable "igw_name_tag" {}
variable "igw_application_id_tag" {}
variable "igw_application_role_tag" {}

#Public route table
variable "pub_rtb_name_tag" {}
variable "pub_rtb_application_id_tag" {}
variable "pub_rtb_application_role_tag" {}

#Private route table
variable "prv_rtb_name_tag" {}
variable "prv_rtb_application_id_tag" {}
variable "prv_rtb_application_role_tag" {}

#common tags
variable "environment_tag" {}
variable "owner_tag" {}
variable "business_unit_tag" {}
variable "financial_tag" {}
variable "security_tag" {}
variable "automation_tag" {}

######################################################################
# Network config settings
##
variable "vpc_cidr"         {}
