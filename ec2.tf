# Bastion system code

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = "assigment-key-pair"
  vpc_security_group_ids = [aws_security_group.bastion-ssh.id]
  subnet_id = module.vpc.public_subnets[0]
 tags = {
    Name = "Bastion"
  }
}

resource "aws_eip" "static" {
  instance = aws_instance.web.id
  vpc      = true
}


#Jenkins EC2
data "aws_ami" "ubuntu3" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "jenkins" {
  ami           = data.aws_ami.ubuntu3.id
  instance_type = "t2.micro"
  key_name      = "assigment-key-pair"
  vpc_security_group_ids = [aws_security_group.private-ssh.id, aws_security_group.public.id]
  subnet_id = module.vpc.private_subnets[0]
 tags = {
    Name = "Jenkins"
  }
}


#App Server EC2
data "aws_ami" "ubuntu1" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "App" {
  ami           = data.aws_ami.ubuntu1.id
  instance_type = "t2.micro"
  key_name      = "assigment-key-pair"
  vpc_security_group_ids = [aws_security_group.public.id, aws_security_group.private-ssh.id]
  subnet_id = module.vpc.private_subnets[1]
 tags = {
    Name = "AppServer"
  }
}