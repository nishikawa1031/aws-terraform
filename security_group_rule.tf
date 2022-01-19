# セキュリティグループ(=AWSにおけるファイアウォールの役割)
## インバウンド通信(サーバーに入ってくる通信)
resource "aws_security_group_rule" "ec2-sg-rule1" {
  type              = "ingress" #インバウンド通信に関するルール(通して良い通信を指定する)
  from_port         = 22 #sshが使用するポート番号は22番と決まっている。(22番だけ通していいと宣言)
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2-sg.id #sshのインバウンド通信を許可
}

resource "aws_security_group_rule" "ec2-sg-rule2" {
  type              = "ingress" #インバウンド通信に関するルール
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2-sg.id
}

## アウトバウンド(サーバーから出ていく通信)
### インバウンドはホワイトリストで管理するのに対して、アウトバウンドは全部許可してしまうことが多い
resource "aws_security_group_rule" "ec2-sg-rule3" {
  type              = "egress" #アウトバウンド通信(外部のコンピュータへのアクセス)を許可
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2-sg.id
}

# rds用のセキュリティグループ
resource "aws_security_group_rule" "rds-sg-rule" {
  type                     = "ingress" #インバウンド通信に関するルール
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ec2-sg.id #アプリケーションサーバ用のセキュリティグループからのアクセスを許可
  security_group_id        = aws_security_group.rds-sg.id
}