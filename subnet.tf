resource "aws_subnet" "subnet_public" {
vpc_id = aws_vpc.vpc_one.id
cidr_block = "10.0.1.0/24"
availability_zone = "eu-north-1a"
map_public_ip_on_launch =true

tags = {
    Name = " aws_subnet_public "
}

}
resource "aws_subnet" "subnet_private" {
    vpc_id = aws_vpc.vpc_one.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "eu-north-1b"
    map_public_ip_on_launch = false
    tags = {
        Name = "aws_subnet_private"
    }
}
# Associate public subnet with public route table
resource "aws_route_table_association"  "public_rt_association" {
subnet_id = aws_subnet.subnet_public.id
route_table_id = aws_route_table.route_table_public.id
}
# # Associate private subnet with private route table
resource "aws_route_table_association" "private_rt_association" {
    subnet_id = aws_subnet.subnet_private.id
    route_table_id = aws_route_table.route_private.id
}