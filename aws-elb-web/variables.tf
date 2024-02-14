#Security group
variable "websg_id" {}

#Subnet
variable "privatesub1_id" {}

variable "privatesub2_id" {}

#ELB
variable "web_elb_name" {}

variable "web_elb_instance_port" {}

variable "healthcheck_target" {
  default = "HTTP:80/"
}

variable "internal" {
  default = "true"
}

variable "idle_timeout" {
  default = "300"
}

#Tag
variable owner_tag {}

variable business_unit_tag {}
variable environment_tag {}
variable elb_application_id_tag {}
variable elb_application_role_tag {}

variable security_tag {}
variable automation_tag {}
variable financial_tag {}
