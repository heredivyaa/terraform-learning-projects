output "public_ip_address" {
  value = aws_instance.example.public_ip #resource_type.resource_name
}