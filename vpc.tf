resource "aws_vpc" "deepgram" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Deepgram"
  }
}