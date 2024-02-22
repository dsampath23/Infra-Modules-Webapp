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
// Create DNS Record 
module "droute53" {
  source              = "./terrafile/infra-modules-webapp/aws-route53-record"
}
```
## Architecture Overview:

Our AWS 3-tier web deployment architecture is designed for high availability and scalability, utilizing multiple availability zones (AZs) within a Virtual Private Cloud (VPC). The architecture includes:

- VPC Design:
A dedicated Virtual Private Cloud (VPC) to isolate and organize resources.

- High Availability:
Two availability zones for redundancy and high availability.

-Subnet Configuration:
Two public subnets in each availability zone for load balancers.
Four private subnets (two for API and two for web) in each availability zone.

-Domain Management:

Utilization of Route 53 for domain management, with www.example.com hosted zone attached to a Load Balancer.
SSL/TLS Security:

ACM certificate generated and validated, attached to the Load Balancer for secure HTTPS communication.
Launch Template:

Creation of launch templates with instance profiles attached for seamless integration with IAM roles.
Auto Scaling:

Implementation of Auto Scaling Groups for both web and API tiers, with policies for automatic scale-up and scale-down based on CPU utilization.
Instances are automatically added to the Load Balancer target group.
Security Groups:

Network traffic filtering at the host level using security groups.
Web server security group allows access only from the web-layer Load Balancer over TCP on ports 80 and 443.
Application server security group allows access only from the application-layer Load Balancer.
