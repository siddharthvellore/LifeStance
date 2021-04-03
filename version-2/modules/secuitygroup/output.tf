output "security_group_id" {
  value = aws_security_group.allow_ssh.id
  description = "The public IP address of the main instance."
}