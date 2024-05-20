provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "damo-server" {
    ami = "ami-0bb84b8ffd87024d8"
    instance_type = "t2.micro"
    key_name = "dpp"
    security_groups = [ "demo-sg" ]
}

resource "aws_security_group" "demo-sg" {
  name        = "demo-sg"
  description = "SSH Access"


  tags = {
    Name = "ssh-port"
  }
}

resource "aws_vpc_security_group_ingress_rule" "demo-sg" {
  security_group_id = aws_security_group.demo-sg.id
  cidr_ipv4         = ["0.0.0.0/0"]
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "demo-sg" {
  security_group_id = aws_security_group.demo-sg.id
  from_port = 0
  to_port =  0
  cidr_ipv4         = ["0.0.0.0/0"]
  ip_protocol       = "-1" # semantically equivalent to all ports
}