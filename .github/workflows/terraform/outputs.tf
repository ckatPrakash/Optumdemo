output "s3_vpc_endpoint_id" {
  value = aws_vpc_endpoint.s3.id
}
output "s3_vpc_endpoint_dns" {
  value = aws_vpc_endpoint.s3.dns_entry[0].dns_name
}
