// Security Group Resource for Module
resource "aws_security_group" "main_security_group" {
    name = "${var.security_group_name}"
    description = "Security Group ${var.security_group_name}"
    vpc_id = "${var.vpc_id}"

    // allow traffic for TCP 80
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["${var.source_cidr_block}"]
    }

    // allow traffic for TCP 443
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["${var.source_cidr_block}"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
	
	tags {
		"Name" 				= "${var.security_group_name}"
		"Environment" 		= "${var.environment_tag}"		
		"Owner"				= "${var.owner_tag}"
		"Business Unit" 	= "${var.business_unit_tag}"
		"Security" 			= "${var.security_tag}"
		"Application Role"	= "${var.application_role_tag}"
		"Application ID"	= "${var.application_id_tag}"
		"Automation"		= "${var.automation_tag}"
		"Financial"			= "${var.financial_tag}"		
  }
}

// Output ID of sg_web SG we made
output "security_group_id_elb" {
  value = "${aws_security_group.main_security_group.id}"
}
