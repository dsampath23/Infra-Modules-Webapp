output "public_subnets_ids" {
  value = "${join(",", aws_subnet.public.*.id)}"
}
