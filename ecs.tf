resource "aws_ecs_cluster" "kvs_dg_integrator_cluster" {
  name = "kvs-dg-integrator-cluster2"
  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

resource "aws_ecs_task_definition" "kvs_dg_integrator" {
  family                   = "kvs-dg-integrator-task-family"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "1024"
  execution_role_arn       = aws_iam_role.kvs_dg_integrator_execution_role.arn
  task_role_arn            = aws_iam_role.kvs_dg_integrator_task_role.arn
  runtime_platform {
    operating_system_family = "LINUX"
  }
  container_definitions = jsonencode([
    {
      name  = "kvs-dg-integrator-container"
      image = "${var.environment.account_id}.dkr.ecr.${var.environment.region}.amazonaws.com/kvs-dg-integrator:latest"
      links = []
      portMappings = [{
        containerPort = 80
        hostPort      = 80
        protocol      = "tcp"
        appProtocol   = "http"
      }]
      entryPoint= []
      environmentFiles = []
      command = []
      environmentFiles = []
      secrets = []
      dnsServers = []
      dnsSearchDomains = []
      extraHosts = []
      dockerSecurityOptions = []
      dockerLabels = {}
      ulimits = []
      secretOptions = []
      systemControls = []
      credentialSpecs = []
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

resource "aws_ecs_service" "kvs_dg_integrator_ecs_service" {
  name            = "kvsDgIntegratorEcsService"
  cluster         = aws_ecs_cluster.kvs_dg_integrator_cluster.id
  task_definition = aws_ecs_task_definition.kvs_dg_integrator.arn
  desired_count   = "1"
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.deepgram_a.id,aws_subnet.deepgram_b.id]
    security_groups  = [aws_security_group.kvsDgIntegratorEcs.id]
    assign_public_ip = true  # Change to false for private subnets with NAT
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.kvs_dg_integrator_tg.arn
    container_name   = "kvs-dg-integrator-container"
    container_port   = 80
  }

  # Dependency enforcement
  depends_on = [aws_lb_listener.kvs_dg_integrator_listener]
}
