// Module specific variables
variable "security_group_name" {
  description = "The name for the security group"
}

variable "vpc_id" {
  description = "The VPC this security group will go in"
}

variable "source_cidr_block" {
  description = "The source CIDR block to allow traffic from"
}
variable "rdp_cidr_block" {
	  description = "The source CIDR block to allow remoted desktop"
}

#Tag
variable owner_tag { }
variable business_unit_tag {}
variable environment_tag {}
variable application_id_tag {}
variable application_role_tag {}
variable security_tag {}
variable automation_tag {}
variable financial_tag { }
