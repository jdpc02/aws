#
# Set's up the VPC and internet gateway
#
resource "aws_vpc" "clientvpc" {
    cidr_block           = "${lookup(var.CIDRAZ, format("%s%s", lookup(var.RegionMap, var.workreg), var.Env))}"
    enable_dns_support   = true
    enable_dns_hostnames = true

    tags = {
        Name = "Client VPC"
        Tool = "terraform"
    }
}

resource "aws_internet_gateway" "clientigw" {
    vpc_id = "${aws_vpc.clientvpc.id}"

    tags = {
        Name = "Client Internet Gateway"
        Tool = "terraform"
    }
}

resource "aws_eip" "clienteip" {
    vpc        = true
    depends_on = ["aws_internet_gateway.clientigw"]

    tags = {
        Name = "Client Elastic IP"
        Tool = "terraform"
    }
}

output "clientvpc" {
  value = "${aws_vpc.clientvpc.id}"
}

output "clientigw" {
  value = "${aws_internet_gateway.clientigw.id}"
}

output "clienteip" {
  value = "${aws_eip.clienteip.id}"
}
