resource "aws_iam_role" "kvs_dg_integrator_execution_role" {
  name = "kvsDgIntegratorExecutionRole2"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "kvs_dg_integrator_cloudwatch" {
  name        = "PolicyForCloudwatch"
  path        = "/"
  description = "Policy to allow Lambda to write to Cloudwatch on each invokation"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "logs:CreateLogGroup"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "kvs_dg_integrator_ecs" {
  depends_on = []
  role       = aws_iam_role.kvs_dg_integrator_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "kvs_dg_integrator_cloudwatch" {
  depends_on = [aws_iam_policy.kvs_dg_integrator_cloudwatch]
  role       = aws_iam_role.kvs_dg_integrator_execution_role.name
  policy_arn = aws_iam_policy.kvs_dg_integrator_cloudwatch.arn
}

resource "aws_iam_role" "kvs_dg_integrator_task_role" {
  name = "kvsDgIntegratorTaskRole2"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "kvs_dg_integrator_task_kvs" {
  depends_on = []
  role       = aws_iam_role.kvs_dg_integrator_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonKinesisVideoStreamsReadOnlyAccess"
}


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

