resource "aws_instance" "my_instance" {
  ami = var.ami
  count = var.instance_count
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [var.vpc_security_group_ids]
  subnet_id = var.subnet_id

  tags = {
    created_by = "terraform"
    // Takes the instance_name input variable and adds
    //  the count.index to the name., e.g.
    //  "example-host-web-1"
    Name = "${var.instance_name}-${count.index+1}"
  }
}