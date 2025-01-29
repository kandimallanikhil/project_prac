resource "aws_vpc" "vpc_one" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "terraform_vpc"
    }
    enable_dns_support = true
    enable_dns_hostnames = true
}
