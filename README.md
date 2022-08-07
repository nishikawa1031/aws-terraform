Udemyの「ゼロから実践するamazon web services」内の構成をterraformで作成してみた


# terraform output で確認できること
eip
rds-endpoint

# ec2への接続方法
ssh -i id_rsa_terraform ec2-user@{terraform outputで確認したeip}

## CICDpipelineの実装の参考記事
https://qiita.com/okubot55/items/1dc50e9f85e77dadf1e0