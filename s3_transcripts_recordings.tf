resource "aws_s3_bucket" "transcripts" {
  bucket = "${var.environment.tla}-recordings-transcripts"
}

resource "aws_s3_bucket" "q" {
  bucket = "${var.environment.tla}-connect-amazonq"
}