resource "aws_ecs_cluster" "kvs_dg_integrator_cluster" {
  name = "kvs-dg-integrator-cluster"
  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

resource "aws_ecs_task_definition" "kvs_dg_integrator" {
  family                   = "kvs-dg-integrator-task-family"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = aws_iam_role.kvs_dg_integrator_execution_role.arn
  task_role_arn            = aws_iam_role.kvs_dg_integrator_task_role.arn

  container_definitions = jsonencode([
    {
      name  = "kvs-dg-integrator-container"
      image = "${var.environment.account_id}.dkr.ecr.${var.environment.region}.amazonaws.com/kvs-dg-integrator:latest"
      portMappings = [{
        containerPort = 80
        hostPort      = 80
        protocol      = "tcp"
        appProtocol   = "http"
      }]
      environment = [
        { name = "DEEPGRAM_API", value = var.deepgram.deepgram_api },
        { name = "DEEPGRAM_API_KEY", value = var.deepgram.deepgram_api_key },
        { name = "LOG_LEVEL", value = var.deepgram.kvs_dg_integrator_log_level },
        { name = "APP_REGION", value = var.environment.region }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/kvs-dg-integrator"
          awslogs-region        = "${var.environment.region}"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}
