
resource "aws_instance" "t2micro_instance" {
  count = 3
  ami = "ami-04f5641b0d178a27a"
  instance_type = "t2.micro"

  tags= {
    Name= "t2micro_instance.${count.index}"
  }
  //user_data = <<-EOF
}