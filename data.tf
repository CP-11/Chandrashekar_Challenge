data "aws_subnet" "public_subnet" {
  filter {
    name   = "tag:Type"
    values = ["public"]
  }

  availability_zone = var.az
  vpc_id            = var.vpc_id
}