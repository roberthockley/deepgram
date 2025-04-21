resource "aws_cloudwatch_log_group" "kvs_dg_trigger" {
  name              = "/aws/lambda/${aws_lambda_function.kvs_dg_trigger.function_name}"
  retention_in_days = 7
}

resource "aws_lambda_function" "kvs_dg_trigger" {
  function_name = "kvsDgTrigger"
  role          = aws_iam_role.dg_trigger_role.arn
  timeout       = 900
  package_type  = "Image"
  image_uri     = "${var.environment.account_id}.dkr.ecr.${var.environment.region}.amazonaws.com/kvs-dg-trigger:latest"

  environment {
    variables = {
      #KVS_DG_INTEGRATOR_DOMAIN = aws_lb.kvs_dg_integrator_lb.dns_name
      LOG_LEVEL                = "debug"
    }
  }

  #vpc_config {
  #  security_group_ids = [aws_security_group.kvsDgTrigger.id]
   # subnet_ids        = [aws_subnet.deepgram_a.id,aws_subnet.deepgram_b.id]
  #}
}