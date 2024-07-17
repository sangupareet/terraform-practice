provider "aws" {
  
}
data "aws_ami" "dev" {
  most_recent = true
  owners = [ "amazon" ]
  filter {
    name = "name"
    values = [ "amzn2-ami-hvm-*-gp2" ]
  }
  filter {
    name = "root-device-type"
    values = [ "ebs" ]
  }
  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }
}
data "aws_subnet" "dev" {
  id = "subnet-0d73590aacae16ba6"
}
data "aws_security_group" "dev" {
  id = "sg-005f0ea67d59e2720"
}
resource "aws_instance" "dev" {
  ami = data.aws_ami.dev.id
  instance_type = "t2.micro"
  key_name = "sriram"
  subnet_id = data.aws_subnet.dev.id
  security_groups = [ data.aws_security_group.dev.id ]
  tags = {
    Name = "dev-ec2"
  }
}