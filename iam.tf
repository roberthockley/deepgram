resource "aws_iam_role" "kvs_dg_integrator_execution_role" {
  name               = "kvsDgIntegratorExecutionRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action    = "sts:AssumeRole"
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

resource "aws_iam_role_policy_attachment" "kvs_dg_integrator_execution_role" {
    depends_on = [  ]
  role       = aws_iam_role.kvs_dg_integrator_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "kvs_dg_integrator_execution_role" {
    depends_on = [ aws_iam_policy.kvs_dg_integrator_cloudwatch ]
  role       = aws_iam_role.kvs_dg_integrator_execution_role.name
  policy_arn = aws_iam_policy.kvs_dg_integrator_cloudwatch.arn
}