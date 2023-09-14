resource "aws_security_group" "vm_sg" {
  name        = "${var.name}-allow-access"
  description = "SG to control traffic to ${var.name} instance"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.name}-security-grp"
    Env  = var.environment
  }
}

resource "aws_security_group_rule" "vm_sg_secure" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.vm_sg.id
}

## not good for SSH, ok for demos
resource "aws_security_group_rule" "vm_sg_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.vm_sg.id
}

resource "aws_security_group_rule" "vm_sg_insecure" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.vm_sg.id
}

resource "aws_instance" "webserver" {
  ami               = "ami-053b0d53c279acc90" /*ubuntu*/
  availability_zone = var.az
  instance_type     = "t2.micro"

  subnet_id                   = split("/", data.aws_subnet.public_subnet.arn)[1]
  security_groups             = [aws_security_group.vm_sg.id]
  key_name                    = aws_key_pair.vm_pub_key.id
  associate_public_ip_address = "true"

  root_block_device {
    volume_size = "15"
    volume_type = "standard"

    tags = {
      Name = "${var.name}-ebs"
      Env  = var.environment
    }
  }

  tags = {
    Name = var.name
    Env  = var.environment
  }
}