resource "aws_eip" "my-eip" {
  vpc = true #elastic ip addressをインスタンスに紐付ける。
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.my-instance.id
  allocation_id = aws_eip.my-eip.id
}