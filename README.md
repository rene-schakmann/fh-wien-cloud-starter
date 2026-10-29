# fh-wien-cloud-starter

Starter project for the FH Wien cloud exercise: provision a small AWS environment (VPC, subnets, gateway, security group and a web server on EC2) with Terraform.

> 📖 New to Terraform? Read the official introduction first: <https://www.terraform.io/intro>

## Before you start

- **AWS CLI works** – it should still be set up from your previous exercise. Otherwise follow the [installation guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).
- **Credentials are valid** – check that the access key and secret key in `~/.aws/credentials` are still valid. If not, [rotate your access keys](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html#rotating_access_keys_console).

## Set up Terraform

1. Install Terraform for your operating system: [Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
2. Verify the installation (see *"Verify the installation"* in the guide above):

   ```sh
   terraform -help
   ```

## Exercise

`main.tf` and `provider.tf` give you a starting point.

1. Initialize your working directory:

   ```sh
   terraform init
   ```

2. Adapt `main.tf` to provision the infrastructure described in the [specification](#specification).
3. Attach your `main.tf` to the assignment.

### Steps

Create your infrastructure in this order:

1. VPC
2. Two subnets within your VPC
3. Internet gateway
4. Route table
5. Security group
6. EC2 instance
   - attach it to the security group you created
   - place it in the **public** subnet
   - start the web server automatically by adding:

     ```hcl
     user_data = file("${path.module}/startup.sh")
     ```

   - use an [Amazon Linux AMI](https://aws.amazon.com/amazon-linux-2/), e.g. `ami-076309742d466ad69`

### Verify

1. Open the AWS Console in your browser and find your EC2 instance's **public IP**.
2. Open `http://<your-public-ip>` – you should see the nginx welcome page.

## Specification

*Same as in the PDF.*

| Resource            | Configuration                                                                                   |
| ------------------- | ----------------------------------------------------------------------------------------------- |
| VPC                 | CIDR `10.0.0.0/16`                                                                              |
| Subnet 1 (public)   | CIDR `10.0.1.0/24`, auto-assign public IPv4 address: **true**                                   |
| Subnet 2 (private)  | CIDR `10.0.2.0/24`, auto-assign public IPv4 address: **false**                                  |
| Internet gateway    | attached to the VPC                                                                             |
| Security group      | allow inbound TCP from every IPv4 address (`0.0.0.0/0`) on ports **80** and **443**              |
| Route table         | route `cidr_block = "0.0.0.0/0"` → `gateway_id = <your internet gateway>`                       |

## Clean up

When you're done, delete everything to avoid costs:

```sh
terraform destroy
```
