# Infra-Modules-Webapp
COde is for 3 tier architerture for web hosting which includes aws best practices. Not going to explain in depth about the consideration of parameters since that would take consume lot of time and lines.
These are the modules which can be called upon with any other repos

## Modules list

- Application Gateway
- Azure Front Door
- Virtual Machine
- DNS Record
- Network Security Group
- Network Interface
- Resource Group
- Virtual Network

- #### Create DNS Record example:
```go
// Create Azure DNS Record for EDOCS
module "dns_a_record" {
  source              = "./terrafile/azure-modules/dns_record"
  resgrp              = var.azure_dns_rg_name
  a_record_name       = var.a_record_name
  azure_dns_zone_name = var.azure_dns_zone_name
  frontdoor_dns_id    = module.azure_front_door.frontdoor_dns
}
```
