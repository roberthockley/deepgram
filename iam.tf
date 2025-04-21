resource "aws_iam_role" "dg_trigger_role" {
  name = "Deepgram-kvsDgTriggerRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "dg_trigger_role" {
  depends_on = []
  role       = aws_iam_role.dg_trigger_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

