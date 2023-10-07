# Outputs file
output "vpc_id" {
  value = data.aws_vpc.default.id
}
output "subnet" {
  value = data.aws_subnet.default.arn
}
output "instance_eip" {
  value = aws_eip.hycho-demo-eip.*.public_ip
}
output "private_key" {
  value = var.key_pair
}
output "public_dns" {
  value = aws_eip.hycho-demo-eip.*.public_dns
}


