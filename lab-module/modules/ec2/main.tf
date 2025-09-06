# modules/ec2/main.tf

# Get the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Get the default VPC
data "aws_vpc" "default" {
  default = true
}

# Get subnets in the default VPC (modern data source)
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Create an EC2 instance in the first available default subnet
resource "aws_instance" "this" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  subnet_id     = tolist(data.aws_subnets.default.ids)[0]

  tags = {
    Name = "MyEC2Instance"
  }
}

