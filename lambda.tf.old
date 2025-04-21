resource "aws_cloudwatch_log_group" "lambda_outbound" {
  name              = "/aws/lambda/${aws_lambda_function.lambda_makeCampaign.function_name}"
  retention_in_days = 7
}

resource "aws_lambda_layer_version" "lambda_layer_dynamodb" {
  filename            = "dynamodb_layer.zip"
  layer_name          = "dynamodb"
  description         = "^3.744.0"
  compatible_runtimes = ["nodejs22.x"]
}

resource "aws_lambda_layer_version" "lambda_layer_scheduler" {
  filename            = "scheduler_layer.zip"
  layer_name          = "scheduler"
  description         = "^3.782.0"
  compatible_runtimes = ["nodejs22.x"]
}

resource "aws_lambda_layer_version" "lambda_layer_eventbridge" {
  filename            = "eventbridge_lambda_layer.zip"
  layer_name          = "eventbridge_lambda"
  description         = "^3.744.0"
  compatible_runtimes = ["nodejs22.x"]
}

resource "aws_lambda_layer_version" "lambda_layer_csv" {
  filename            = "csv_layer.zip"
  layer_name          = "csv_lambda"
  description         = "^5.6.0"
  compatible_runtimes = ["nodejs22.x"]
}

resource "aws_lambda_function" "lambda_makeCampaign" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "outbound_makeCamapign.zip"
  function_name = "outbound-makeContactsTable"
  description   = "Lambda to make dedicated DynamoDB table for campaign"
  role          = aws_iam_role.RoleForMakeCampaign.arn
  handler       = "index.handler"
  publish       = true
  layers        = [aws_lambda_layer_version.lambda_layer_dynamodb.arn, aws_lambda_layer_version.lambda_layer_eventbridge.arn]
  runtime       = "nodejs22.x"
  memory_size   = "128"
  timeout       = "30"
  ephemeral_storage {
    size = 512 # Min 512 MB and the Max 10240 MB
  }
  environment {
    variables = {
      readCampaignFunctionARN  = ""
      readCampaignFunctionName = ""
      roleARN                  = aws_iam_role.RoleForMakeCampaignEvents.arn
    }
  }
}


resource "aws_lambda_function" "lambda_csv" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "csv2Dynamo.zip"
  function_name = "csv2Dynamo"
  description   = "Lambda to upload CSV Call Lists to DynamoDB"
  role          = aws_iam_role.RoleForCSV2Dynamo.arn
  handler       = "index.handler"
  publish       = true
  layers        = [aws_lambda_layer_version.lambda_layer_dynamodb.arn, aws_lambda_layer_version.lambda_layer_csv.arn]
  runtime       = "nodejs22.x"
  memory_size   = "128"
  timeout       = "30"
  ephemeral_storage {
    size = 512 # Min 512 MB and the Max 10240 MB
  }
}

resource "aws_lambda_function" "lambda_unmarshalledDynamo" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "unmarshalledDynamo.zip"
  function_name = "unmarshalledDynamo"
  description   = "Lambda to upload CSV Call Lists to DynamoDB"
  role          = aws_iam_role.RoleForMakeCampaign.arn
  handler       = "index.handler"
  publish       = true
  layers        = [aws_lambda_layer_version.lambda_layer_dynamodb.arn]
  runtime       = "nodejs22.x"
  memory_size   = "128"
  timeout       = "30"
  ephemeral_storage {
    size = 512 # Min 512 MB and the Max 10240 MB
  }
}

resource "aws_cloudwatch_log_group" "lambda_postcallsummary" {
  name              = "/aws/lambda/${aws_lambda_function.lambda_postcallsummary.function_name}"
  retention_in_days = 7
}

resource "aws_lambda_layer_version" "lambda_layer_postcallsummary" {
  filename            = "postcallsummary_layer.zip"
  layer_name          = "postcallsummary_layer"
  description = "Bedrock Connect ContactLens @aws-sdk ^3.741.0"
  compatible_runtimes = ["nodejs20.x", "nodejs22.x"]
}

resource "aws_lambda_function" "lambda_postcallsummary" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "lambda_postcallsummary.zip"
  function_name = "PostCallSummary"
  role          = aws_iam_role.iam_role_lambda_post_call_Summary.arn
  handler       = "index.handler"
  publish       = true
  layers        = [aws_lambda_layer_version.lambda_layer_postcallsummary.arn]
  runtime       = "nodejs20.x"
  memory_size   = "128"
  timeout       = "30"
  ephemeral_storage {
    size = 512 # Min 512 MB and the Max 10240 MB
  }
  environment {
    variables = {
      Connect_Instance = "${aws_connect_instance.song.id}"
    }
  }
}

resource "aws_lambda_permission" "allow_eventbridge_invoke_lambda_postcallsummary" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_postcallsummary.function_name
  principal     = "events.amazonaws.com"

  # Reference the ARN of the EventBridge Rule
  source_arn = aws_cloudwatch_event_rule.postcallsummary.arn
}

resource "aws_lambda_function" "lambda_scheduler" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "lambda_scheduler.zip"
  function_name = "SetSchedule"
  role          = aws_iam_role.RoleForMakeCampaign.arn
  handler       = "index.handler"
  publish       = true
  layers        = [aws_lambda_layer_version.lambda_layer_scheduler.arn]
  runtime       = "nodejs20.x"
  memory_size   = "128"
  timeout       = "30"
  ephemeral_storage {
    size = 512 # Min 512 MB and the Max 10240 MB
  }
  environment {
    variables = {
      lambda = "${aws_lambda_function.lambda_makeCampaign.arn}"
      role = "${aws_iam_role.RoleForMakeCampaign.arn}"
    }
  }
}