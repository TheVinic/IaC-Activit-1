resource "aws_lb" "region1_lb_main" {
  name = replace("${var.project} LB", " ", "-")
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.region1_main["loadbalance"].id]
  
  subnets = "${aws_subnet.region1_public.*.id}"

  tags = {
    Name = "${var.project} LB"
  }
}

resource "aws_lb_listener" "region1_http_lb_main_listener" {
  load_balancer_arn = aws_lb.region1_lb_main.arn
  protocol = "HTTP"
  port = "80"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "application/json"
      message_body = "{ \"status\":\"otherwise not routed\" }"
      status_code = "200"
    }
  }
}

resource "aws_lb_target_group" "region1_instances" {
  name = "${var.project}-tg"
  protocol = "HTTP"
  vpc_id = aws_vpc.region1_vpc.id
  port = 80
}

resource "aws_lb_target_group_attachment" "region1_instances" {
  count = length(aws_instance.region1_main.*.id)
  target_group_arn = aws_lb_target_group.region1_instances.arn
  target_id = aws_instance.region1_main[count.index].id
  port = 80
}
#Region 2
resource "aws_lb" "region2_lb_main" {
  provider = aws.west
  name = replace("${var.project} LB", " ", "-")
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.region2_main["loadbalance"].id]
  subnets = "${aws_subnet.region2_public.*.id}"

  tags = {
    Name = "${var.project} LB"
  }
}

resource "aws_lb_listener" "region2_http_lb_main_listener" {
  provider = aws.west
  load_balancer_arn = aws_lb.region2_lb_main.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "application/json"
      message_body = "{ \"status\":\"otherwise not routed\" }"
      status_code = "200"
    }
  }
}

resource "aws_lb_target_group" "region2_instances" {
  provider = aws.west
  name = "${var.project}-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.region2_vpc.id
}

resource "aws_lb_target_group_attachment" "region2_instances" {
  provider = aws.west
  count = length(aws_instance.region2_main.*.id)

  target_group_arn = aws_lb_target_group.region2_instances.arn
  target_id = aws_instance.region2_main[count.index].id
  port = 80
}