resource "aws_instance" "gov_uk_vm" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_http.id]
  subnet_id = var.subnet_id

  tags = {
    Name = "gov-uk-vm"
  }
}

data "aws_eip" "gov_uk_ip" {
  filter {
    name   = "tag:Name"
    values = ["gov-uk-ec2"]
  }
}

resource "aws_eip_association" "gov_uk_eip" {
  instance_id   = aws_instance.gov_uk_vm.id
  allocation_id = data.aws_eip.gov_uk_ip.id
}

resource "aws_security_group" "allow_http" {
  name        = "gov-uk-sg"
  description = "Allow http, ssh inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.inbound_cidr
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.inbound_cidr
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.inbound_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "gov-uk-sg"
  }
}