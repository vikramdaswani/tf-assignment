output "vpc_id"{
    value = aws_vpc.main.id
}

output "elb_dns_name"{
    value = main
}

output "instance_ip"{
    value = [aws_instance.instance[0].public_ip, aws_instance.instance[1].public_ip]
}

output "public_subnet_ids"{
    value = aws_subnet.public_subnet[*].id
}

output "private_subnet_ids"{
    value = aws_subnet.private_subnet[*].id
}