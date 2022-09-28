# fh-wien-cloud-starter

Read the official introduction into terraform: https://www.terraform.io/intro

# Before you start
* Ensure that your AWS CLI is working (should still be working from your previous exercise, otherwise see https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
* Ensure your access key and secret key in your .aws/credentials files are valid (if not please see https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html#rotating_access_keys_console)

# Setup Terraform
* Install terraform according to the guide for your operating system https://learn.hashicorp.com/tutorials/terraform/install-cli
* Verify that it is working -> see Documentation "Verify the installation"

# Exercise
* main.tf and provider.tf provide a starter for you. 
* use "terraform init" to initialize your terraform state
* Adapt the main.tf file according to the infrastructure you should provision
* Attach the main.tf to the assignment

You should create your infrastructure in this order:

* Create your VPC
* Create two subnets within your VPC
* Create internet gateway
* Create Routing Table
* Create Security Group
* Create your ec2 instance (add the EC2 instance to the created security group, add it to the public subnet)
* Add the following attribute to your EC2 Instance to automatically start your web server:  user_data = file("${path.module}/startup.sh")
* Navigate to your AWS Console in your browser, locate your EC2 instance to get your public IP
* Open http://your-public-ip to verify your web server is working

Specification (same as in the PDF):
* VPC with 10.0.0.0/16
* Subnet 1 10.0.1.0/24, Auto-assign public IPv4 address: True
* Subnet 10.0.2.0/24, Auto-assign public IPv4 address: False
* Internet Gateway
* Security Group Rules: Allow tcp traffic from every ipv4 adr. To all clients of that security group on port 80 and 443
* Route table with routing rule: cidr_block = "0.0.0.0/0", gateway_id = your gateway 