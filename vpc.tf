resource "aws_vpc" "my-vpc" {
  cidr_block           = "10.0.0.0/16"
  # CIDRとは、1ビット単位で可変長の「サブネットマスク」（subnet mask）を用いてネットワーク部の大きさを指定するというIPアドレスの記法のこと。
   # 上の場合は、16ビットがネットワークアドレス部で、残り8ビットがホストアドレス部。
  # VPC内で決めるIPアドレスは、VPC内でのみ利用するため自由に設定できます。
   # (許可されているのは、/28 ネットマスクから /16 ネットマスクの間のブロックサイズです。)
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true 
  # パブリック IP アドレスを持つインスタンスが、対応するパブリック DNS ホスト名を取得するかどうか
  # どういう意味？
   # vpc内にパブリックサブネットを作成した場合に、そのIPアドレスの名前解決をするかどうかってことかな。
  tags = {
    Name = "my-vpc"
  }
}