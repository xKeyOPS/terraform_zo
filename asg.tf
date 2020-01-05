
resource "aws_autoscaling_group" "worker" {
  # Force a redeployment when launch configuration changes.
  # This will reset the desired capacity if it was changed due to
  # autoscaling events.
  name = "${aws_launch_configuration.worker.name}-asg"

  min_size             = 10
  desired_capacity     = 15
  max_size             = 25
  health_check_type    = "EC2"
  launch_configuration = "${aws_launch_configuration.worker.name}"
  vpc_zone_identifier  = ["${aws_subnet.public.*.id}"]

  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }
}