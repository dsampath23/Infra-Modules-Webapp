######################################################################
# Create the VPC and tag it
###
resource "aws_vpc" "vpc" {
    cidr_block           = "${var.vpc_cidr}"
    enable_dns_support   = true
    enable_dns_hostnames = true
    enable_default_roots = true
    tags                 = {
							                "Name"				= "${var.vpc_name_tag}"
							                "Application ID" 	= "${var.vpc_application_id_tag }"
							                "Application Role"	= "${var.vpc_application_role_tag}"
							                "Environment"		= "${var.environment_tag}"
                           }
}

######################################################################
## Route table for public subnets
###
resource "aws_route_table" "public-route-table" {
   vpc_id = "${aws_vpc.vpc.id}"
   route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.igw.id}"
   }
   tags   = {
							"Name"				= "${var.pub_rtb_name_tag}"
							"Application ID" 	= "${var.pub_rtb_application_id_tag }"
							"Application Role"	= "${var.pub_rtb_application_role_tag}"
							"Environment"		= "${var.environment_tag}"
             }
}

######################################################################
## Route table for private subnets
###
resource "aws_route_table" "private-route-table" {
   vpc_id = "${aws_vpc.vpc.id}"
   route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_vpn_gateway.vpn-gateway.id}"
   }
   tags   = {
							"Name"				= "${var.prv_rtb_name_tag}"
							"Application ID" 	= "${var.prv_rtb_application_id_tag }"
							"Application Role"	= "${var.prv_rtb_application_role_tag}"
							"Environment"		= "${var.environment_tag}"

             }
}
