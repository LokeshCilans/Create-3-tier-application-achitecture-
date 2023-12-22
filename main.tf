# Create a VPC
resource "aws_vpc" "lokesh_vpc" {
  cidr_block = "10.0.0.0/16"
}

# Create a subnet in the VPC
resource "aws_subnet" "lokesh_subnet" {
  vpc_id            = aws_vpc.lokesh_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "ap-south-1a"
}

# Create an internet gateway for the VPC
resource "aws_internet_gateway" "lokesh_internet_gateway" {
  vpc_id = aws_vpc.lokesh_vpc.id
}

# Create a route table and associate it with the subnet
resource "aws_route_table" "lokesh_route_table" {
  vpc_id = aws_vpc.lokesh_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lokesh_internet_gateway.id
  }
}

# Create an IAM role
resource "aws_iam_role" "lokesh_role" {
  name = "lokesh-role_1"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# Create an IAM instance profile
resource "aws_iam_instance_profile" "lokesh_instance_profile" {
  name = "lokesh-instance-profile-1"
  role = aws_iam_role.lokesh_role.name
}

# Create a security group
resource "aws_security_group" "lokesh_security_group" {
  name        = "lokesh-security-group-1"
  description = "Security group for Elastic Beanstalk environment"
  vpc_id      = aws_vpc.lokesh_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an Elastic Beanstalk application
resource "aws_elastic_beanstalk_application" "lokesh_app" {
  name = "lokesh-application"
}

# Create an Elastic Beanstalk environment
resource "aws_elastic_beanstalk_environment" "lokesh_environment" {
  name                = "lokesh-environment"
  application         = aws_elastic_beanstalk_application.lokesh_app.name
  solution_stack_name = "64bit Amazon Linux 2023 v4.0.3 running Python 3.9"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.lokesh_instance_profile.name
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = aws_vpc.lokesh_vpc.id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", [aws_subnet.lokesh_subnet.id])  # Wrap the subnet ID in a list
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.micro"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = "test"
  }
}