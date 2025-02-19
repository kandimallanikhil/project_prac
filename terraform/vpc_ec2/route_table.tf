# Create a route table public.
resource "aws_route_table" "route_table_public"{
    vpc_id =aws_vpc.vpc_one.id
    tags = {
        Name = "public_route"
    }
}

# creating a private route table.
resource "aws_route_table" "route_private" {
vpc_id = aws_vpc.vpc_one.id
tags= {
    Name = "route_private"
}
}

# adding routes to the table for the route table created above.
resource "aws_route" "public_route" {
    route_table_id = aws_route_table.route_table_public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id

}

# Creating a private routte to attach a natgateway.
resource "aws_route" "route_table_private" {
   route_table_id  = aws_route_table.route_private.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id         =  aws_nat_gateway.nat_gateway.id
}