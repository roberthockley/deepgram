resource "aws_security_group" "kvsDgIntegratorEcs" {
  name        = "Deepgram-kvsDgIntegratorEcsServiceSecurityGroup"
  vpc_id      = aws_vpc.deepgram.id
  description = "Security group for kvs-dg-integrator Fargate task"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
  tags = {
    Name = "Deepgram-kvsDgIntegratorEcsServiceSecurityGroup"
  }
}

resource "aws_security_group_rule" "kvsDgIntegratorEcs" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.kvsDgIntegratorLoadBalancer.id
  security_group_id        = aws_security_group.kvsDgIntegratorEcs.id
  description              = "Allow HTTP from source security group"
}


resource "aws_security_group" "kvsDgTrigger" {
  name        = "Deepgram-kvsDgTriggerSecurityGroup"
  vpc_id      = aws_vpc.deepgram.id
  description = "Security group for kvs-dg-trigger Lambda function"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
  tags = {
    Name = "Deepgram-kvsDgTriggerSecurityGroup"
  }
}

resource "aws_security_group" "kvsDgIntegratorLoadBalancer" {
  name        = "Deepgram-kvsDgIntegratorLoadBalancerSecurityGroup"
  vpc_id      = aws_vpc.deepgram.id
  description = "Security group for kvs-dg-integrator load balancer"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
  tags = {
    Name = "Deepgram-kvsDgIntegratorLoadBalancerSecurityGroup"
  }
}

resource "aws_security_group_rule" "kvsDgIntegratorLoadBalancer" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.kvsDgTrigger.id
  security_group_id        = aws_security_group.kvsDgIntegratorLoadBalancer.id
  description              = "Allow HTTP from source security group"
}