resource "aws_instance" "web_instance" {
  ami             = "ami-01216e7612243e0ef"
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.web_instance_security_group.name}"]
  tags = {
    "Name" = "web_instance"
  }
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd.x86_64
              systemctl start httpd.service
              systemctl enable httpd.service
              echo “Hello World from $(hostname -f)” > /var/www/html/index.html
              EOF

  user_data_replace_on_change = true
}


resource "aws_security_group" "web_instance_security_group" {
  name = "allow traffic on port 80"
  #   vpc_id = "vpc-08cc437310bab770c"
  ingress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "web instance security group[allow traffic on port 8080]"
    from_port        = 80
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 80
  }]

  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "allow traffic from all ports"
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "all"
    security_groups  = []
    self             = false
    to_port          = 0
  }]
}
