resource "aws_subnet" "deepgram_a" {
  vpc_id            = aws_vpc.deepgram.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-southeast-1a"
  tags = {
    Name = "Deepgram_A"
  }
}

resource "aws_subnet" "deepgram_b" {
  vpc_id            = aws_vpc.deepgram.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "ap-southeast-1b"
  tags = {
    Name = "Deepgram_B"
  }
}
