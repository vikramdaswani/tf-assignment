# Create an elastic load balancer
resource "aws_elb" "main" {
    name = var.elb_name
    availability_zones = var.availability_zones
    access_logs {
        bucket = "vikramsamplebucket"
        bucket_prefix = "pre"
        interval = 60
    }
    listener {
        instance_port = var.elb_instance_port
        instance_protocol = "http"
        lb_port = var.elb.lb_port_http
        lb_protocol = "http"
    }
    listener {
        instance_port = var.elb_instance_port
        instance_protocol = "http"
        lb_port = var.elb.lb_port_http
        lb_protocol = "https"
    }
    health_check {
        healthy_threshold = var.elb.health_check["healthy_threshold"]
        unhealthy_threshold = var.elb.health_check["unhealthy_threshold"]
        timeout = var.elb.health_check["timeout"]
        target = var.elb.health_check["target"]
        interval = var.elb.health_check["interval"]
    }
    instances = [aws_instance.instance.id]
    cross_zone_load_balancing = var.elb_cross_zone_load_balancing
    idle_timeout = var.elb_idle_timeout
    connection_draining = var.elb_connection_draining
    connection_draining_timeout = var.elb_connection_draining_timeout
    tags = {
        Name = var.elb_tags
    }
}