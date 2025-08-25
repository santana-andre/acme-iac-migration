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

              cat <<EOT > /var/www/html/index.html
              <!DOCTYPE html>
              <html lang="en">
              <head>
                  <meta charset="UTF-8">
                  <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
                          background: rgba(0, 0, 0, 0.6);
                          padding: 40px;
                          border-radius: 12px;
                          box-shadow: 0 4px 20px rgba(0,0,0,0.3);
                          text-align: center;
                          max-width: 600px;
                      }
                      h1 {
                          font-size: 2.5em;
                          margin-bottom: 10px;
                          color: #00d4ff;
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
                      <p>Provisionado automaticamente com <strong>Terraform</strong> + <strong>AWS</strong>.</p>
                  </div>
              </body>
              </html>
              EOT
            EOF


  tags = var.tags
}
