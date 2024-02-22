# Infra-Modules-Webapp

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

- Subnet Configuration:
Two public subnets in each availability zone for load balancers.
Four private subnets (two for API and two for web) in each availability zone.

- Domain Management:
Utilization of Route 53 for domain management, with example.com hosted zone attached to a Load Balancer.

- SSL/TLS Security:
ACM certificate generated and validated, attached to the Load Balancer for secure HTTPS communication.

- Launch Template:
Creation of launch templates with instance profiles attached for seamless integration with IAM roles.

- Auto Scaling:
Implementation of Auto Scaling Groups for both web and API tiers, with policies for automatic scale-up and scale-down based on CPU utilization.
Instances are automatically added to the Load Balancer target group.

- Security Groups:
Network traffic filtering at the host level using security groups.
Web server security group allows access only from the web-layer Load Balancer over TCP on ports 80 and 443.
Application server security group allows access only from the application-layer Load Balancer.

#### Best Practices which needs to be considered:

- Bastion Host:
To provide a secure gateway for connecting to instances in VPC.
- Web Application Firewall (WAF):
Implementation of WAF to filter malicious traffic, including cross-site scripting (XSS) and SQL injection, based on customer-defined rules.
- DDoS Protection:
Automatic safeguards against common network and transport layer DDoS attacks.
- Deployment Strategy:
Utilization of red-black deployment for service updates to ensure minimal downtime and rollback capabilities.
- Caching Mechanism:
Implementation of caching mechanisms for improved performance and reduce latency.

NOte: Few more smaller details in code level have not configured due to time constraint.
