resource "aws_launch_configuration" "worker" {
  # Launch Configurations cannot be updated after creation with the AWS API.
  # In order to update a Launch Configuration, Terraform will destroy the
  # existing resource and create a replacement.
  #
  # We're only setting the name_prefix here,
  # Terraform will add a random string at the end to keep it unique.
  name_prefix = "worker-"

  image_id                    = "${data.aws_ami.amazon_linux.id}"
  instance_type               = "${var.worker_instance_type}"
  security_groups             = ["${aws_security_group.worker.id}"]

  user_data = "${data.template_cloudinit_config.user_data.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}