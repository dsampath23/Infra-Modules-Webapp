## Output vars

output "vpc_id" {
   value = "${aws_vpc.vpc.id}"
}

output "vpc_cidr" {
   value = "${var.vpc_cidr}"
}

output "public_route_table_id" {
   value = "${aws_route_table.public-route-table.id}"
}

output "private_route_table_id" {
   value = "${aws_route_table.private-route-table.id}"
}
