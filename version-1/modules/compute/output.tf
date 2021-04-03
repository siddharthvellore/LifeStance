output "instance_ip_addr" {
  value = aws_instance.my_instance.*.private_ip
  description = "The public IP address of the main instance."
}