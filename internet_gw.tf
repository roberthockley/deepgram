resource "aws_internet_gateway" "deepgram" {
  vpc_id = aws_vpc.deepgram.id
  tags = {
    Name = "Deepgram"
  }
}

resource "aws_internet_gateway_attachment" "deepgram" {
  internet_gateway_id = aws_internet_gateway.deepgram.id
  vpc_id              = aws_vpc.deepgram.id
}