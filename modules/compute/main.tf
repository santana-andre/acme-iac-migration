resource "aws_security_group" "web" {
  vpc_id = var.vpc_id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.tags
}

resource "aws_instance" "web" {
  ami                    = "ami-053b0d53c279acc90" # Ubuntu 22.04 us-east-1
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [aws_security_group.web.id]

  user_data = <<-EOF
                #!/bin/bash
                apt-get update -y
                apt-get install -y apache2
                systemctl start apache2
                systemctl enable apache2
                echo "<h1>Hello ACME - IaC OK (Ubuntu)</h1>" > /var/www/html/index.html
              EOF

  tags = var.tags
}
