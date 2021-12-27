# セキュリティグループを利用して、コントロールパネルからインスタンス毎に仮想ファイアウォールの設定ができるため、
# 個別にiptablesを設定するのに比べて作業の手間を省けます。
## 
resource "aws_security_group" "ec2-sg" {
  name   = "ec2-sg"
  vpc_id = aws_vpc.my-vpc.id
}
