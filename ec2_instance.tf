resource "aws_instance" "t2micro_instance" {
  ami           = "ami-04f5641b0d178a27a"
  instance_type = "t2.micro"

  tags = {
    Name = "t2micro_instance"
  }
}