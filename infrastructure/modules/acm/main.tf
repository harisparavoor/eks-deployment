/*resource "aws_acm_certificate" "main" {
domain_name = var.domain_name
#validation_method = "DNS"

lifecycle {
create_before_destroy = true
}
}
*/
/*resource "aws_route53_record" "cert_validation" {
for_each = {
for dvo in aws_acm_certificate.main.domain_validation_options : dvo.domain_name => {
name = dvo.resource_record_name
record = dvo.resource_record_value
type = dvo.resource_record_type
}
}

allow_overwrite = true
name = each.value.name
records = [each.value.record]
ttl = 60
type = each.value.type
zone_id = var.route53_zone_id
}
*/
/*resource "aws_acm_certificate_validation" "main" {
certificate_arn = aws_acm_certificate.main.arn
validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}
*/
resource "tls_private_key" "apptest_com" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_self_signed_cert" "apptest_com" {
  private_key_pem = tls_private_key.apptest_com.private_key_pem

  subject {
    common_name  = "apptest.com"
    organization = "Test Org"
  }

  validity_period_hours = 720  # 30 days

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "aws_acm_certificate" "self_signed" {
  private_key      = tls_private_key.apptest_com.private_key_pem
  certificate_body = tls_self_signed_cert.apptest_com.cert_pem
}