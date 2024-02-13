######################################################################
## Private Subnets
###
resource "aws_subnet" "private" { 
	vpc_id                  = "${var.vpc_id}"
	cidr_block        		= "${element(split(",", var.private_subnets), count.index)}"
	availability_zone 		= "${element(split(",", var.azs), count.index)}"
	count             		= "${length(compact(split(",", var.private_subnets)))}"
	map_public_ip_on_launch = false
	tags                    = {
								"Name"				= "${element(split(",", var.subnet_name_tag), count.index)}"
								"Application ID" 	= "${var.sub_application_id_tag }"
								"Application Role"	= "${var.sub_application_role_tag}"
								"Environment"		= "${var.environment_tag}"

                             }
}

resource "aws_route_table_association" "private-rtb" {
	count = "${length(compact(split(",", var.private_subnets)))}"
	subnet_id = "${element(aws_subnet.private.*.id, count.index)}"
	route_table_id = "${var.private_route_table_id}"
}
