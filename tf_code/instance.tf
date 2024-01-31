data "aws_ami" "amazon_linux" {
    most_recent = true
    filter {
        name = "instance"
        values = ["amazn2-ami-hvm-*-x86_64-gp2"]
    }
    owners = ["amazon"]
}

resource "aws_instance" "ec2"{
    count = length(var.public_subnet_cidr)
    ami = data.aws_ami.amzn_linux.id
    instance_type = var.instance_type
    subnet_id = var.public_subnet_cidr[count.index]
}