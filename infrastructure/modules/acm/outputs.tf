/*output "certificate_arn" {
description = "ARN of the ACM certificate"
value = aws_acm_certificate_validation.main.certificate_arn
}
*/
/*
output "validated_certificate_arn" {
  description = "ARN of the validated ACM certificate"
  value       = aws_acm_certificate_validation.main.certificate_arn
}
*/

output "certificate_arn" {
description = "ARN of the ACM certificate"
value = aws_acm_certificate.self_signed.arn
}