variable "aws_region" {
    default = ["us-east-1"]
}
variable "aws_vpc" {
    default = "main"
}
variable "availability_zones"{
    default = ["us-east-1a", "us-east-1b"]
}
variable "vpc_cidr_block" {
    default = "10.0.0.0/16"
}
variable "public_subnet_cidr"{
    default = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "private_subnet_cidr" {
    default = ["10.0.3.0/24", "10.0.4.0/24"]
}
variable "ssh_cidr_block" {
    description = "cidr block fpr ssh access"
    default = "10.0.0.0/16"
}
variable "http_cidr_block"{
    description = "cidr block for http"
    default = "0.0.0.0/0"
}
variable "https_cidr_block"{
    description = "cidr block for https"
    default = "0.0.0.0/0"
}
variable "allowed_ports"{
    description = "list of allowed ports for SG"
    default = [22, 80, 443]
}
variable "instance_type"{
    default = "t2.micro"
}
variable "elb_name" {
    default = "vikram-terraform-elb"
}
variable "elb_bucket_name" {
    default = "vikramsamplebucket"
}
variable "elb_bucket_prefix" {
    default = "pre"
}
variable "elb_instance_port" {
    default = 8080
}
variable "elb_lb_port_http" {
    default = [80,443]
}
variable "elb_ssl_certificate_id" {
    default = "arn:aws:iam::12345678901:"
}
variable "elb_health_check" {
    default = {
        healthy_threshold = 2
        unhealthy_threshold = 2
        timeout = 3
        target = "HTTP:8080/"
        interval = 30
    }
}
variable "elb_cross_zone_load_balancing" {
    default = true
}
variable "elb_idle_timeout" {
    default = 400
}
variable "elb_connection_draining" {
    default = true
}
variable "elb_connection_draining_timeout" {
    default = 400
}
variable "elb_tags" {
    default = {
        Name = "test-elb"
    }
}