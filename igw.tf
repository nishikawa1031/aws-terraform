# internet gatewayとは
## vpcと関連付けることでインターネットとvpc間の相互アクセスが可能となる。
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "my-igw"
  }
}