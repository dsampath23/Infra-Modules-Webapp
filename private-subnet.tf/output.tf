output "subnets_ids" {
  value = "${join(",", aws_subnet.private.*.id)}"
}
