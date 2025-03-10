resource "aws_instance" "web" {
  ami           = "ami-0eba6c58b7918d3a1"
  instance_type = "t2.micro"
  network_interface {
    network_interface_id = aws_network_interface.web.id
    device_index         = 0
  }
  user_data = file("wordpress.sh")

  tags = {
    Name = "web"
  }
}

resource "aws_network_interface" "web" {
  subnet_id       = aws_subnet.public.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.web.id]
}

resource "aws_eip" "wordpress" {
  network_interface = aws_network_interface.web.id
  domain            = "vpc"
}
