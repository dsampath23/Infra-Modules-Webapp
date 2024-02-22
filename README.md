# Infra-Modules-Webapp
COde is for 3 tier architerture for web hosting which includes aws best practices. Not going to explain in depth about the consideration of parameters since that would take consume lot of time and lines.
These are the modules which can be called upon with any other repos

## Modules list

- Route 53 
- ALB
- ACM
- EC2
- Security Groups
- Autoscaling Groups
- VPC
- Subnets
- IAM

- #### Create DNS Record example:
```go
// Create Azure DNS Record for EDOCS
module "dns_a_record" {
  source              = "./terrafile/infra-modules-webapp/aws-route53-record"
}
```
