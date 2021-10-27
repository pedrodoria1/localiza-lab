resource "aws_vpc" "vpc_network_aws" {
  cidr_block = "172.16.0.0/16"
}

resource "aws_subnet" "subnet_aws" {
  vpc_id            = aws_vpc.vpc_network_aws.id
  cidr_block        = "172.16.0.0/24"
  availability_zone = "us-west-2a"
}

resource "aws_network_interface" "nic_instance_1" {
  subnet_id   = aws_subnet.subnet_aws.id
  private_ips = ["172.16.0.10"]
}