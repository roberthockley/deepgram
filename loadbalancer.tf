resource "aws_lb" "kvs_dg_integrator_lb" {
  name               = "kvs-dg-integrator-lb"
  internal           = true
  load_balancer_type = "application"
  subnets            = [aws_subnet.deepgram_a.id,aws_subnet.deepgram_b.id]
  security_groups    = [aws_security_group.kvs_dg_integrator_lb_sg.id]
}

resource "aws_lb_target_group" "kvs_dg_integrator_tg" {
  name     = "kvs-dg-integrator-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.deepgram.id
  target_type = "ip"

  health_check {
    path                = "/health-check"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "kvs_dg_integrator_listener" {
  load_balancer_arn = aws_lb.kvs_dg_integrator_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.kvs_dg_integrator_tg.arn
  }
}