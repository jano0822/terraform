# create EC2
resource "aws_instance" "janoinstance" {
  ami           = "ami-0e10dad03266d08d9" # valid AMI ID in your region
  instance_type = "t2.micro"

  tags = {
    name = "jano-instance"
  }
}