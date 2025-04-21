resource "aws_internet_gateway" "deepgram" {
  vpc_id = aws_vpc.deepgram.id
  tags = {
    Name = "Deepgram"
  }
}
