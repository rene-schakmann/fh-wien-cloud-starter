resource "aws_vpc" "my-first-vpc" {
  tags = {
    Name = "my-first-vpc"
  }
  cidr_block = "10.0.0.0/28"
}