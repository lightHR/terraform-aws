# --- loadbalancing/main.tf

resource "aws_lb" "mtc_lb" {
  name            = "mtc-loadbalancer"
  subnets         = var.public_subnets
  security_groups = [var.public_sg]
  idle_timeout    = 400
}

resource "aws_lb_target_group" "mtc_tg" {
  name     = "mtc-lb-tg-${substr(uuid(), 0, 3)}"
  port     = var.tg_port
  protocol = var.tg_protocol
  vpc_id   = var.vpc_id
  health_check {
    healthy_threshold   = var.lb_healthy_threshold
    unhealthy_threshold = var.lb_unhealthy_thresshold
    timeout             = var.lb_timeout
    interval            = var.lb_interval
  }
}

resource "aws_lb_listener" "mtc_lb_listener"{
    load_balancer_arn = aws_lb.mtc_lb.arn
    port = var.listener_port #80
    protocol = var.listener_protocol # "HTTP"
    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.mtc_tg.arn
    }
}
