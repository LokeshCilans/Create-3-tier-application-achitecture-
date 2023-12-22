# Terraform AWS Infrastructure

## Overview

This Terraform script automates the deployment of essential AWS infrastructure components for your application, including a Virtual Private Cloud (VPC), subnet, internet gateway, route table, IAM role, instance profile, security group, and an Elastic Beanstalk environment.

## Prerequisites

Before you begin, ensure you have the following prerequisites installed:

1. [Terraform](https://www.terraform.io/downloads.html)
2. [AWS CLI](https://aws.amazon.com/cli/) configured with the necessary credentials.

## Getting Started

1. **Clone this repository:**

   ```bash
   git clone <repository-url>
   cd <repository-directory>

# Terraform AWS Infrastructure

## Getting Started

1. **Initialize Terraform:**

    ```bash
    terraform init
    ```

2. **Review and Update Configuration:**

    Review the `main.tf` file and update variables or configurations as needed for your project.

3. **Apply the Terraform Configuration:**

    ```bash
    terraform apply
    ```

    Type `yes` when prompted to confirm the changes.

## Infrastructure Details

- **VPC:** `10.0.0.0/16`
- **Subnet:** `10.0.0.0/24` in `ap-south-1a`
- **Internet Gateway:** Attached to the VPC
- **Route Table:** Routes all traffic (`0.0.0.0/0`) through the Internet Gateway
- **IAM Role:** `app-role` for EC2 instances
- **IAM Instance Profile:** `app-instance-profile` associated with the IAM role
- **Security Group:** Allows inbound traffic on port 80
- **Elastic Beanstalk Application:** `my-app`
- **Elastic Beanstalk Environment:** `my-environment` running Python 3.9 on `t2.micro` instances

## Cleanup

To avoid incurring charges, run:

```bash
terraform destroy

## Additional Resources

Terraform Documentation
AWS Elastic Beanstalk Documentation

**Feel free to adapt and customize this script according to your specific requirements. Happy coding! 🚀🌍💻**
