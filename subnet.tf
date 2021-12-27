# サブネットとは
## vpcだとipアドレスの範囲が広いので、
## それを小さいipアドレスの範囲に分割して使いやすくするもの
resource "aws_subnet" "aws-and-infra-public-subnet-1a" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.10.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "aws-and-infra-public-subnet-1a"
  }
}

# https://www.terraform.io/language/resources/syntax#resource-syntax
## aws-and-infra-private-subnet-1cがローカル名
resource "aws_subnet" "aws-and-infra-private-subnet-1c" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.20.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "aws-and-infra-private-subnet-1c"
  }
}

resource "aws_db_subnet_group" "db-sg" {
  name       = "db-sg"
  subnet_ids = [aws_subnet.aws-and-infra-public-subnet-1a.id, aws_subnet.aws-and-infra-private-subnet-1c.id]
}
