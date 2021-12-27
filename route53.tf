resource "aws_route53_zone" "loyal_memo_zone" {
   name = "loyalmemo.com"
}

resource "aws_route53_record" "loyal_memo_record" {
   zone_id = "${aws_route53_zone.loyal_memo_zone.zone_id}"
   name = "loyalmemo.com"
   type = "A"
   ttl = "300"
   records = [aws_eip.my-eip.public_ip]
}