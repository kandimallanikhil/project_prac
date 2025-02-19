# Create NAT Gateway Elastic IP
resource "aws_eip" "elastic_ip" {
     domain = "vpc" 
 }
 #Creating an NAT gateway 
 resource "aws_nat_gateway" "nat_gateway" {
    allocation_id = aws_eip.elastic_ip.id
    subnet_id = aws_subnet.subnet_public.id
 }
