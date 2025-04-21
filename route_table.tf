resource "aws_route_table" "deepgram" {
  vpc_id = aws_vpc.deepgram.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.deepgram.id
  }
  tags = {
    Name = "Deepgram"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.deepgram_a.id
  route_table_id = aws_route_table.deepgram.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.deepgram_b.id
  route_table_id = aws_route_table.deepgram.id
}