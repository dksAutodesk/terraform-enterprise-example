#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-eea9f38e
#
# Your subnet ID is:
#
#     subnet-7e08481a
#
# Your security group ID is:
#
#     sg-834d35e4
#
# Your Identity is:
#
#     autodesk-mussel
#

terraform {
  backend "atlas" {
    name = "seemand/training"
  }
}

variable aws_access_key {
  type = "string"
}

variable aws_secret_key {
  type = "string"
}

variable aws_region {
  type    = "string"
  default = "us-west-1"
}

variable instance_count {
  type    = "string"
  default = "3"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  count                  = "${var.instance_count}"
  ami                    = "ami-eea9f38e"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-7e08481a"
  vpc_security_group_ids = ["sg-834d35e4xxx"]

  tags {
    Identity = "autodesk-mussel"
    Name     = "seemand-example ${count.index + 1} / ${var.instance_count}"
    Date     = "04:ll:2017"
  }
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}
