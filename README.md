# 🚀 AWS Infrastructure Framework - Enhanced Edition

**Build production-ready AWS infrastructure in minutes with Terraform**

A professional, secure, and highly scalable AWS infrastructure framework built with best practices in mind. This framework deploys a complete cloud environment with VPC, load balancer, auto-scaling, monitoring, backups, and WAF protection.

---

## ✨ Features

### 🏗️ **Infrastructure**
- ✅ **High Availability**: Multi-AZ deployment across 2-3 availability zones
- ✅ **VPC with Public/Private Subnets**: Secure network architecture
- ✅ **NAT Gateway**: Secure outbound internet access for private instances
- ✅ **Internet Gateway**: Public subnet connectivity
- ✅ **VPC Flow Logs**: Network traffic monitoring
- ✅ **VPC Endpoints**: Private access to AWS services (S3)

### ⚖️ **Load Balancing & Scaling**
- ✅ **Application Load Balancer**: Layer 7 load balancing with health checks
- ✅ **Auto Scaling Group**: Dynamic scaling based on demand
- ✅ **Target Groups**: Health monitoring and traffic distribution
- ✅ **HTTPS Support**: SSL/TLS termination (when certificate provided)

### 🔒 **Security**
- ✅ **AWS WAF**: Web Application Firewall with managed rules
- ✅ **Security Groups**: Layered network security
- ✅ **IMDSv2**: Instance metadata service v2 enforced
- ✅ **Encrypted EBS Volumes**: Data encryption at rest
- ✅ **IAM Roles**: Least privilege access for instances
- ✅ **SSM Session Manager**: Secure shell access without SSH keys

### 📊 **Monitoring & Alerting**
- ✅ **CloudWatch Alarms**: CPU, memory, and health monitoring
- ✅ **CloudWatch Dashboard**: Centralized metrics visualization
- ✅ **SNS Notifications**: Email alerts for critical events
- ✅ **CloudWatch Logs**: Centralized logging
- ✅ **Custom Metrics**: Application-level monitoring

### 💾 **Backup & Disaster Recovery**
- ✅ **AWS Backup**: Automated daily backups
- ✅ **Retention Policies**: Configurable backup retention
- ✅ **Point-in-Time Recovery**: Restore to any backup point
- ✅ **Cross-Region Support**: Multi-region backup capability

### 🎛️ **Customization**
- ✅ **Fully Variable-Driven**: Every aspect configurable via variables
- ✅ **Environment-Specific**: Separate configurations for dev/staging/prod
- ✅ **Team Tagging**: Engineer name, team name, organization
- ✅ **Cost Center Tracking**: Budget and cost allocation tags
- ✅ **Dynamic Web Page**: Auto-generated page with instance metadata

---

## 📋 Prerequisites

Before you begin, ensure you have:

1. **AWS Account** with appropriate permissions
2. **AWS CLI** configured with credentials
3. **Terraform** >= 1.0 installed
4. **Basic understanding** of AWS and Terraform

### Install Terraform
```bash
# macOS (using Homebrew)
brew install terraform

# Linux
wget https://releases.hashicorp.com/terraform/1.7.0/terraform_1.7.0_linux_amd64.zip
unzip terraform_1.7.0_linux_amd64.zip
sudo mv terraform /usr/local/bin/

# Verify installation
terraform version
```

### Configure AWS CLI
```bash
aws configure
# Enter your AWS Access Key ID, Secret Access Key, and default region
```

---

## 🚀 Quick Start

### 1. Clone and Setup
```bash
# Navigate to the project directory
cd terraform-enhanced

# Copy the example variables file
cp terraform.tfvars.example terraform.tfvars

# Edit terraform.tfvars with your values
nano terraform.tfvars
```

### 2. Customize Your Configuration

Edit `terraform.tfvars` and set your values:
```hcl
# Basic Configuration
project_name      = "MyProject"
environment       = "dev"
engineer_name     = "Your Name"
team_name         = "Your Team"
region            = "us-east-1"

# Email for alerts
alarm_email = "your-email@example.com"

# For production, enable these:
# enable_auto_scaling = true
# enable_waf = true
# enable_backups = true
```

### 3. Deploy Infrastructure
```bash
# Initialize Terraform (download providers and modules)
terraform init

# Preview what will be created
terraform plan

# Deploy the infrastructure
terraform apply

# Type 'yes' when prompted
```

### 4. Access Your Application

After deployment completes, Terraform will output the website URL:
```bash
# View all outputs
terraform output

# Get the website URL
terraform output website_url
```

Open the URL in your browser to see your application running!

---

## 📁 Project Structure
```
terraform-enhanced/
├── provider.tf           # AWS provider and backend configuration
├── variables.tf          # All customizable variables (70+ variables)
├── locals.tf            # Computed values and common tags
├── network.tf           # VPC, subnets, route tables, NAT Gateway
├── security-groups.tf   # Security group rules
├── compute.tf           # EC2 instances, Launch Template, Auto Scaling
├── load-balancer.tf     # ALB, Target Groups, Listeners, WAF
├── monitoring.tf        # CloudWatch alarms, SNS, Dashboard
├── backup.tf            # AWS Backup configuration
├── outputs.tf           # Output values
├── terraform.tfvars.example  # Example configuration
├── .gitignore           # Git ignore file
└── README.md            # This file
```

---

## 🎯 Configuration Options

### Environment Types

The framework supports three environment types:

#### 🧪 Development (Cost-Optimized)
```hcl
environment              = "dev"
instance_type            = "t3.micro"
instance_count           = 1
single_nat_gateway       = true   # Cost saving
enable_waf               = false
enable_backups           = false
enable_cloudwatch_alarms = false
```

#### 🔬 Staging (Balanced)
```hcl
environment              = "staging"
instance_type            = "t3.small"
instance_count           = 2
single_nat_gateway       = false
enable_waf               = true
enable_backups           = true
enable_cloudwatch_alarms = true
```

#### 🏭 Production (High Availability)
```hcl
environment                = "prod"
instance_type              = "t3.medium"
enable_auto_scaling        = true
asg_min_size               = 3
asg_max_size               = 10
az_count                   = 3
single_nat_gateway         = false
enable_waf                 = true
enable_https               = true
enable_backups             = true
backup_retention_days      = 30
enable_deletion_protection = true
```

### Key Variables

| Variable | Description | Default | Required |
|----------|-------------|---------|----------|
| `project_name` | Name of your project | "Cloud-Project" | Yes |
| `environment` | Environment (dev/staging/prod) | "dev" | Yes |
| `engineer_name` | Engineer managing infrastructure | - | Yes |
| `team_name` | Team responsible | - | Yes |
| `region` | AWS region | "us-east-1" | Yes |
| `instance_type` | EC2 instance type | "t3.micro" | No |
| `enable_auto_scaling` | Use Auto Scaling Group | false | No |
| `enable_waf` | Enable WAF protection | true | No |
| `alarm_email` | Email for alerts | "" | No |

See `variables.tf` for all available options.

---

## 🔒 Security Best Practices

This framework implements AWS security best practices:

1. **Network Security**
   - Private subnets for application tier
   - Public subnets only for load balancer
   - Security groups with least privilege

2. **Data Protection**
   - Encrypted EBS volumes
   - WAF protection against common attacks
   - VPC Flow Logs for audit

3. **Access Control**
   - IAM roles with minimal permissions
   - SSM Session Manager (no SSH keys)
   - IMDSv2 enforced

4. **Monitoring**
   - CloudWatch alarms for anomalies
   - Automated backup and recovery
   - Centralized logging

---

## 📊 Monitoring & Alerts

### CloudWatch Dashboard

Access your dashboard at:
```
https://console.aws.amazon.com/cloudwatch/home?region=<REGION>#dashboards
```

### Alert Types

The framework monitors:
- ✅ CPU utilization (threshold: 80%)
- ✅ Memory utilization (threshold: 80%)
- ✅ Instance health checks
- ✅ Load balancer health
- ✅ 5xx errors
- ✅ Response time
- ✅ NAT Gateway errors

### Configure Email Alerts

Set your email in `terraform.tfvars`:
```hcl
alarm_email = "ops-team@example.com"
```

You'll receive a confirmation email from AWS SNS. Click the confirmation link to start receiving alerts.

---

## 💾 Backup & Recovery

### Automated Backups

Backups run daily at 2 AM UTC by default. Configure:
```hcl
enable_backups        = true
backup_retention_days = 7
backup_schedule       = "cron(0 2 * * ? *)"
```

### Restore from Backup
```bash
# List available backups
aws backup list-recovery-points-by-backup-vault \
  --backup-vault-name <vault-name>

# Restore from backup (via AWS Console is recommended)
```

---

## 🔧 Advanced Configuration

### Enable HTTPS

1. Create an ACM certificate in AWS Certificate Manager
2. Update `terraform.tfvars`:
```hcl
enable_https    = true
certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/xxxxx"
```

### Enable Auto Scaling
```hcl
enable_auto_scaling  = true
asg_min_size         = 2
asg_max_size         = 10
asg_desired_capacity = 3
```

### Restrict Access by IP
```hcl
allowed_cidr_blocks = ["203.0.113.0/24", "198.51.100.0/24"]
```

---

## 🛠️ Useful Commands

### View Infrastructure
```bash
# Show all resources
terraform state list

# Show specific resource details
terraform state show aws_instance.app_servers[0]

# View all outputs
terraform output

# Get specific output
terraform output website_url
```

### Access Instances
```bash
# Using SSM Session Manager (recommended)
aws ssm start-session --target i-1234567890abcdef0

# View instance logs
aws logs tail /aws/MyProject-dev/vpc-flow-logs --follow
```

### Update Infrastructure
```bash
# Make changes to terraform.tfvars or *.tf files
nano terraform.tfvars

# Preview changes
terraform plan

# Apply changes
terraform apply
```

### Destroy Infrastructure
```bash
# Destroy all resources (WARNING: This cannot be undone!)
terraform destroy

# Destroy specific resource
terraform destroy -target=aws_instance.app_servers[0]
```

---

## 💰 Cost Optimization Tips

### For Development/Testing:

1. **Use smaller instances**: `t3.micro` instead of `t3.medium`
2. **Single NAT Gateway**: Set `single_nat_gateway = true`
3. **Disable unnecessary features**:
```hcl
   enable_waf               = false
   enable_backups           = false
   enable_cloudwatch_alarms = false
```
4. **Destroy when not in use**: `terraform destroy`

### For Production:

1. **Use Reserved Instances or Savings Plans** for predictable workloads
2. **Enable Auto Scaling** to scale down during low traffic
3. **Use S3 lifecycle policies** for log retention
4. **Review CloudWatch metrics** and optimize over time

---

## 🐛 Troubleshooting

### Issue: Terraform init fails
```bash
# Clear cache and re-initialize
rm -rf .terraform .terraform.lock.hcl
terraform init
```

### Issue: Apply fails with permission errors

Ensure your AWS credentials have the necessary permissions:
- VPC, EC2, Load Balancer creation
- IAM role/policy creation
- CloudWatch, WAF, Backup services

### Issue: Can't access website

1. Check security group rules
2. Verify instances are healthy in target group
3. Check ALB listener rules
4. Review CloudWatch logs

### Issue: Costs higher than expected

Run AWS Cost Explorer to identify high-cost resources:
- NAT Gateways (consider single NAT for dev)
- Load Balancers
- Data transfer
- EBS volumes

---

## 📚 Additional Resources

- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS VPC Best Practices](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-security-best-practices.html)
- [Terraform Best Practices](https://www.terraform-best-practices.com/)

---

## 📝 License

This project is licensed under the MIT License.

---

## 👏 Credits

**Built with ❤️ by the DevOps Community**

Special thanks to:
- Nexus Solutions
- Mohamed Tarek (Cloud Engineer)
- All contributors

---

## 📧 Support

For questions or issues:
- Open an issue on GitHub
- Contact your DevOps team
- Consult AWS Support

---

## 🎉 What's Next?

After deploying your infrastructure:

1. ✅ **Customize the web application** in the user_data script
2. ✅ **Add more services** (RDS, ElastiCache, etc.)
3. ✅ **Implement CI/CD pipelines**
4. ✅ **Set up monitoring dashboards**
5. ✅ **Configure domain and SSL certificate**
6. ✅ **Add application-level security**

---

**Happy WORK! 🚀**
