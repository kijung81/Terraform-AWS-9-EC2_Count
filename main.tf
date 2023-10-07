data "aws_vpc" "default" {
  id = var.vpc_id
}
data "aws_subnet" "default" {
  id = var.subnet_id
}

data "aws_key_pair" "hycho-demo-key" {
  key_name = var.key_pair
}

resource "aws_security_group" "hycho-demo-security" {
  name   = "${var.prefix}-sg"
  vpc_id = data.aws_vpc.default.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.prefix}-sg"
  }
}
data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20220426.0-x86_64-gp2"]
  }
  owners = ["137112412989"]
}
resource "aws_eip" "hycho-demo-eip" {
  count = length (var.instance_name)
  domain      = "vpc"
  tags = {
    Name = "${element(var.instance_name, count.index)}"
  }
}
resource "aws_eip_association" "hycho-demo-asso" {
  count = length (var.instance_name)
  instance_id   = aws_instance.hycho-demo-instance[count.index].id
  allocation_id = aws_eip.hycho-demo-eip[count.index].id
}

resource "aws_instance" "hycho-demo-instance" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  key_name                    = data.aws_key_pair.hycho-demo-key.key_name
  associate_public_ip_address = true
  subnet_id                   = data.aws_subnet.default.id
  vpc_security_group_ids      = [aws_security_group.hycho-demo-security.id]
  count = length(var.instance_name)
  tags = {
    Name = "${element(var.instance_name, count.index)}"
  }
}