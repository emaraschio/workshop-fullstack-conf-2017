terraform {
  required_version = "> 0.9.0"
}

provider "aws" {
  region = "${var.region}"
}

module "ecs_cluster" {
  source = "./ecs-cluster"

  name = "ecs-noteboard"
  size = 6
  instance_type = "t2.micro"
  key_pair_name = "${var.key_pair_name}"

  vpc_id = "${data.aws_vpc.default.id}"
  subnet_ids = ["${data.aws_subnet.default.*.id}"]

  allow_ssh_from_cidr_blocks = ["0.0.0.0/0"]

  allow_inbound_ports_and_cidr_blocks = "${map(
    var.noteboard_client_port, "0.0.0.0/0",
    var.noteboard_api_port, "0.0.0.0/0"
  )}"
}

module "noteboard_api" {
  source = "./ecs-service"

  name = "noteboard-api"
  ecs_cluster_id = "${module.ecs_cluster.ecs_cluster_id}"
  
  image = "${var.noteboard_api_image}"
  version = "${var.noteboard_api_version}"
  cpu = 1024
  memory = 768
  desired_count = 2
  
  container_port = "${var.noteboard_api_port}"
  host_port = "${var.noteboard_api_port}"
  elb_name = "${module.noteboard_api_elb.elb_name}"

  num_env_vars = 2
  env_vars = "${map("RAILS_ENV", "production")}"
}

module "noteboard_api_elb" {
  source = "./elb"

  name = "noteboard-api-elb"

  vpc_id = "${data.aws_vpc.default.id}"
  subnet_ids = ["${data.aws_subnet.default.*.id}"]

  instance_port = "${var.noteboard_api_port}"
  health_check_path = "health"
}


module "noteboard_client" {
  source = "./ecs-service"

  name = "noteboard-client"
  ecs_cluster_id = "${module.ecs_cluster.ecs_cluster_id}"

  image = "${var.noteboard_client_image}"
  version = "${var.noteboard_client_version}"
  cpu = 1024
  memory = 768
  desired_count = 2

  container_port = "${var.noteboard_client_port}"
  host_port = "${var.noteboard_client_port}"
  elb_name = "${module.noteboard_client_elb.elb_name}"

  num_env_vars = 1
  env_vars = "${map("REACT_APP_API_URL",  "http://${module.noteboard_api_elb.elb_dns_name}")}"
}

module "noteboard_client_elb" {
  source = "./elb"

  name = "noteboard-client-elb"

  vpc_id = "${data.aws_vpc.default.id}"
  subnet_ids = ["${data.aws_subnet.default.*.id}"]

  instance_port = "${var.noteboard_client_port}"
  health_check_path = "health"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_availability_zones" "available" {}

data "aws_subnet" "default" {
  count = "${min(length(data.aws_availability_zones.available.names), 3)}"
  default_for_az = true
  vpc_id = "${data.aws_vpc.default.id}"
  availability_zone = "${element(data.aws_availability_zones.available.names, count.index)}"
}