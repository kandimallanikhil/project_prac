provider "aws"{
region = "eu-north-1"
}

resource "aws_vpc" "main_vpc"{
cidr_block = "10.0.0.0/16"
tags = {
 Name = "vpc_test"
}
}

# Public Subnet
resource "aws_subnet" "public_subnet"{
vpc_id = aws_vpc.main_vpc.id
cidr_block ="10.0.1.0/24"
availability_zone = "eu-north-1a"
map_public_ip_on_launch = true
tags={
Name = "Public_Subnet_Test"
}

}

# Private Subnet
resource "aws_subnet" "private_subnet"{
vpc_id = aws_vpc.main_vpc.id
cidr_block= "10.0.2.0/24"
availability_zone = "eu-north-1c"
tags={
Name = "Private_subnet_Test"
}
}
# Internet Gateway
resource "aws_internet_gateway" "ig_internet" {

vpc_id=aws_vpc.main_vpc.id

tags={
Name="Internet_test"
}
}
# Public Routetable
resource "aws_route_table" "public_route"{
vpc_id=aws_vpc.main_vpc.id
route {
cidr_block ="0.0.0.0/0"
gateway_id=aws_internet_gateway.ig_internet.id
}
tags={
Name="Public_route_test"
}
}
# Public Subnet association
resource "aws_route_table_association" "public_route"{
subnet_id=aws_subnet.public_subnet.id
route_table_id=aws_route_table.public_route.id

}

# Private route table
resource "aws_route_table" "private_Route" {
vpc_id=aws_vpc.main_vpc.id
tags={
Name="private_route_Test"
}
}
# Creating a Natgateway but first we need to create a "elastic IP" for it.

# Elastic ip creation
resource "aws_eip" "eip"{
domain="vpc"
tags={
Name="Elastic_ip"
}
}
# creating a natgateway and association it.
resource "aws_nat_gateway" "nat_gt"{
allocation_id = aws_eip.eip.id
subnet_id=aws_subnet.public_subnet.id
tags={
Name="Natgatway_test"
}
}

# # Create a route in the private route table to use the NAT Gateway
resource "aws_route" "private_nat_route" {
  route_table_id         = aws_route_table.private_Route.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gt.id
}
# # Associate the private route table with the private subnet
resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_Route.id
}











