resource "aws_security_group_rule" "ec2-sg-rule1" {
  type              = "ingress" #インバウンド通信に関するルール
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2-sg.id #sshのインバウンド通信を許可
}

resource "aws_security_group_rule" "ec2-sg-rule2" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2-sg.id
}

resource "aws_security_group_rule" "ec2-sg-rule3" {
  type              = "egress" #アウトバウンド通信(外部のコンピュータへのアクセス)を許可
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2-sg.id
}

resource "aws_security_group_rule" "rds-sg-rule" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ec2-sg.id #アプリケーションサーバ用のセキュリティグループからのアクセスを許可
  security_group_id        = aws_security_group.rds-sg.id
}