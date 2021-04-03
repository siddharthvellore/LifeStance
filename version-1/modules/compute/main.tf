resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["<Your IP>"] #Replace this value with your IP or CIDR Range within VPN
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_instance" "my_instance" {
  depends_on = [aws_security_group.allow_ssh]
  ami = var.ami
  count = var.instance_count
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  subnet_id = var.subnet_id

  tags = {
    created_by = "terraform"
    // Takes the instance_name input variable and adds
    //  the count.index to the name., e.g.
    //  "example-host-web-1"
    Name = "${var.instance_name}-${count.index+1}"
  }
}