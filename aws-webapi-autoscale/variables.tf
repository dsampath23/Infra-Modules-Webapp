

#EC2 Instance for Web and API
variable "webuiapi_ami" {}
variable "webuiapi_instancestype" {}
variable "webuiapi_instancerole" {}
variable "webui_launch_confname" {}
variable "webapi_launch_confname" {}
variable "volume_size" {}


#Security group
variable "webuisg_id" {}
variable "webapisg_id" {}

#Subnet
variable "privatesub1_id" {}
variable "privatesub2_id" {}
variable "privatesub3_id" {}
variable "privatesub4_id" {}

#ELB
variable "webui_elb_name" {}
variable "webapi_elb_name" {}
variable "webui_elb_instance_port" {}
variable "webapi_elb_instance_port" {}

#Auto scale
variable "webui_auto_name" {}
variable "webapi_auto_name" {}
variable "webui_scale_up" {}
variable "webui_scale_down" {}
variable "webapi_scale_up" {}
variable "webapi_scale_down" {}

#Tag
variable "webui_auto_scale_instname" {}
variable "webapi_auto_scale_instname" {}
variable owner_tag {}
variable business_unit_tag {}
variable environment_tag {}
variable uielb_application_id_tag {}
variable uielb_application_role_tag {}
variable apelb_application_id_tag {}
variable apelb_application_role_tag {}
variable security_tag {}
variable automation_tag {}
variable financial_tag {}
