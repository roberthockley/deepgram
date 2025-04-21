resource "aws_security_group" "kvs_dg_trigger_sg" {
  name        = "kvs-dg-trigger-sg"
  description = "Security group for kvs-dg-trigger Lambda function"
  vpc_id      = aws_vpc.deepgram.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
}