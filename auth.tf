resource "aws_key_pair" "vm_pub_key" {
  key_name   = "${var.name}-key-pair"
  public_key = file("~/.ssh/id_ed25519.pub")

  tags = {
    Name = "${var.name}-security-grp"
    Env  = var.environment
  }
}