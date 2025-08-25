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
  set -euxo pipefail

 
  if command -v apt-get >/dev/null 2>&1; then
    apt-get update -y
    apt-get install -y apache2
    systemctl enable --now apache2
  else
    yum update -y
    yum install -y httpd
    systemctl enable --now httpd
  fi

  
  cat > /var/www/html/index.html <<'HTML'
  <!DOCTYPE html>
  <html lang="en">
  <head>
    <meta charset="UTF-8">
    <title>Terraform Demo</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
        color: #fff;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
      }
      .card {
        background: rgba(0,0,0,0.6);
        padding: 40px;
        border-radius: 12px;
        text-align: center;
        box-shadow: 0 4px 20px rgba(0,0,0,0.3);
      }
      h1 {
        font-size: 2.5em;
        color: #00d4ff;
        margin: 0 0 10px;
      }
      p {
        font-size: 1.2em;
        color: #ddd;
      }
    </style>
  </head>
  <body>
    <div class="card">
      <h1>${var.demo_message}</h1>
      <p>Provisionado automaticamente com <b>Terraform</b> + <b>AWS</b>.</p>
    </div>
  </body>
  </html>
  HTML
EOF


  tags = var.tags
}
