 resource  "aws_internet_gateway" "ig" {
 vpc_id = aws_vpc.vpc_one.id
 tags = {
    Name = " aws_internet_gateway_test"
 }
 }
