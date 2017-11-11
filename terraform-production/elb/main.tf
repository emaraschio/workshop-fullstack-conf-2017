resource "aws_elb" "elb" {
  name = "${var.name}"
  subnets = ["${var.subnet_ids}"]
  security_groups = ["${aws_security_group.elb.id}"]
  cross_zone_load_balancing = true

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 10
    timeout = 10
    interval = 20

    target = "HTTP:${var.instance_port}/${var.health_check_path}"
  }

  listener {
    instance_port = "${var.instance_port}"
    instance_protocol = "http"
    lb_port = "${var.lb_port}"
    lb_protocol = "http"
  }
}

resource "aws_security_group" "elb" {
  name = "${var.name}"
  description = "The security group for the ${var.name} ELB"
  vpc_id = "${var.vpc_id}"
}

resource "aws_security_group_rule" "all_outbound_all" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.elb.id}"
}

resource "aws_security_group_rule" "all_inbound_all" {
  type = "ingress"
  from_port = "${var.lb_port}"
  to_port = "${var.lb_port}"
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.elb.id}"
}