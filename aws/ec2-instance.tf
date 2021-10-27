resource "aws_instance" "foo" {
  ami           = "ami-005e54dee72cc1d00" # us-west-2
  instance_type = "t2.micro"

  network_interface {
    network_interface_id = aws_network_interface.nic_instance_1.id
    device_index         = 0
  }

  credit_specification {
    cpu_credits = "unlimited"
  }
}