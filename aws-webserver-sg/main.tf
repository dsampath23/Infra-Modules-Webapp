######################################################################
## Create Security Group for Web Server 1
###
resource "aws_security_group" "sg1" {
  name = "${var.webuisg}"
  description = "SG for WEB UI instances"
  vpc_id = "${var.vpc_id}"
  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["10.0.0.0/8"]
      security_groups = [aws_lb.web_lb.security_groups[0]]
  }

  ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["10.0.0.0/8"]
      security_groups = [aws_lb.web_lb.security_groups[0]]
  }
  
  igress {
      from_port = -1
      to_port = -1
      protocol = "icmp"
      cidr_blocks = ["10.0.0.0/8"]
  }
  tags {
        "Name" 				= "${var.webuisg}"
		"Application ID" 	= "${var.application_id_tag}"
		"Environment" 		= "${var.environment_tag}"		
}

######################################################################
## Create Security Group for Web Server 2
###

resource "aws_security_group" "sg2" {
  name = "${var.webapisg}"
  description = "SG for WEB API instances"

  ingress {
      from_port = 3389
      to_port = 3389
      protocol = "RDP"
      cidr_blocks = ["10.0.0.0/8"]
  }

  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
     

  ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
      from_port = -1
      to_port = -1
      protocol = "icmp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${var.vpc_id}"

    tags {
        "Name" 				= "${var.webapisg}"
		"Application ID" 	= "${var.application_id_tag}"
		"Environment" 		= "${var.environment_tag}"		
}

######################################################################
## Outputs
###


output "webuisg_id" {
   value = "${aws_security_group.sg1.id}"
}

output "webapisg_id" {
   value = "${aws_security_group.sg2.id}"
}
