resource "aws_iam_role" "RoleForMakeCampaign" {
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = ["apigateway.amazonaws.com",
          "lambda.amazonaws.com",
          "scheduler.amazonaws.com"]
        }
      }
    ]
  })
  description = "Allows Lambda functions to call AWS services on your behalf."
  name        = "RoleForMakeCampaign"
}

resource "aws_iam_policy" "RoleForMakeCampaignIAM" {
  name        = "PolicyForMakeCampaignIAM"
  path        = "/"
  description = ""
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "iam:PassRole"
        ],
        "Resource" : [
          "${aws_iam_role.RoleForMakeCampaignEvents.arn}",
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "RoleForMakeCampaignConnect" {
  name        = "PolicyForMakeCampaignConnect"
  path        = "/"
  description = "For Connect permissions"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "connect:StartOutboundVoiceContact",
          "connect:ListPhoneNumbersV2"
        ],
        "Resource" : [
          "*",
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "RoleForMakeCampaign_AmazonDynamoDBFullAccess" {
  depends_on = [aws_iam_role.RoleForMakeCampaign]
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
  role       = "RoleForMakeCampaign"
}

resource "aws_iam_role_policy_attachment" "RoleForMakeCampaign_CloudWatchLogsFullAccess" {
  depends_on = [aws_iam_role.RoleForMakeCampaign]
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
  role       = "RoleForMakeCampaign"
}

resource "aws_iam_role_policy_attachment" "RoleForMakeCampaign_DynamoDBFullAccess" {
  depends_on = [aws_iam_role.RoleForMakeCampaign]
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
  role       = "RoleForMakeCampaign"
}

resource "aws_iam_role_policy_attachment" "RoleForMakeCampaign_LambdaFullAccess" {
  depends_on = [aws_iam_role.RoleForMakeCampaign]
  policy_arn = "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
  role       = "RoleForMakeCampaign"
}

resource "aws_iam_role_policy_attachment" "RoleForMakeCampaign_CloudWatchEventsFullAccess" {
  depends_on = [aws_iam_role.RoleForMakeCampaign]
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchEventsFullAccess"
  role       = "RoleForMakeCampaign"
}

resource "aws_iam_role_policy_attachment" "RoleForMakeCampaign_IAM" {
  depends_on = [aws_iam_role.RoleForMakeCampaign]
  policy_arn = aws_iam_policy.RoleForMakeCampaignIAM.arn
  role       = "RoleForMakeCampaign"
}

resource "aws_iam_role_policy_attachment" "RoleForMakeCampaign_Connect" {
  depends_on = [aws_iam_role.RoleForMakeCampaign]
  policy_arn = aws_iam_policy.RoleForMakeCampaignConnect.arn
  role       = "RoleForMakeCampaign"
}

resource "aws_iam_role" "RoleForMakeCampaignEvents" {
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = ["events.amazonaws.com"]
        }
      }
    ]
  })
  description = "Allows Lambda functions to create event rules on your behalf."
  name        = "RoleForMakeCampaignEvents"
}

resource "aws_iam_role_policy_attachment" "RoleForMakeCampaignEventsTarget" {
  depends_on = [aws_iam_role.RoleForMakeCampaignEvents]
  policy_arn = "arn:aws:iam::aws:policy/service-role/CloudWatchEventsBuiltInTargetExecutionAccess"
  role       = "RoleForMakeCampaign"
}

resource "aws_iam_role_policy_attachment" "RoleForMakeCampaignEventsInvoke" {
  depends_on = [aws_iam_role.RoleForMakeCampaignEvents]
  policy_arn = "arn:aws:iam::aws:policy/service-role/CloudWatchEventsInvocationAccess"
  role       = "RoleForMakeCampaign"
}

resource "aws_iam_role" "RoleForCSV2Dynamo" {
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = ["apigateway.amazonaws.com",
          "lambda.amazonaws.com"]
        }
      }
    ]
  })
  description = "Allows Lambda functions to call AWS services on your behalf."
  name        = "RoleForCSV2Dynamo"
}

resource "aws_iam_policy" "RoleForCSV2Dynamo" {
  name        = "PolicyForCSV2Dynamo"
  path        = "/"
  description = "For the Secret Rotation Lambda"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : "dynamodb:BatchWriteItem",
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "RoleForCSV2Dynamo_PolicyForCSV2Dynamo" {
  depends_on = [aws_iam_role.RoleForCSV2Dynamo]
  policy_arn = aws_iam_policy.RoleForCSV2Dynamo.arn
  role       = "RoleForCSV2Dynamo"
}

resource "aws_iam_role_policy_attachment" "RoleForCSV2Dynamo_CloudWatchLogsFullAccess" {
  depends_on = [aws_iam_role.RoleForCSV2Dynamo]
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
  role       = "RoleForCSV2Dynamo"
}

resource "aws_iam_policy" "bedrock_invoke" {
  name        = "PolicyForBedrock_Invoke"
  path        = "/"
  description = "Policy to allow a post to Bedrock and get results"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Sid" : "Statement1",
        "Effect" : "Allow",
        "Action" : [
          "bedrock:InvokeModel",
          "bedrock:InvokeModelWithResponseStream",
          "connect:ListRealtimeContactAnalysisSegments"
        ],
        "Resource" : [
          "*"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_cloudwatch" {
  name        = "PolicyForCloudwatch"
  path        = "/"
  description = "Policy to allow Lambda to write to Cloudwatch on each invokation"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Sid" : "AllowLambdaLogging",
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource" : "arn:aws:logs:${var.environment.region}:${var.environment.account_id}:log-group:/aws/lambda/${aws_lambda_function.lambda_postcallsummary.function_name}:*"
      }
    ]
  })
}

resource "aws_iam_role" "iam_role_lambda_post_call_Summary" {
  name = "RoleForLambdaPostCallSummary"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_bedrock" {
  role       = aws_iam_role.iam_role_lambda_post_call_Summary.name
  policy_arn = aws_iam_policy.bedrock_invoke.arn
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_role_lambda_post_call_Summary.name
  policy_arn = aws_iam_policy.lambda_cloudwatch.arn
}

## Add other destinations when needed
