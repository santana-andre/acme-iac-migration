############################################
# modules/compute/main.tf
############################################

# 1) Security Group com HTTP liberado
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

  tags = merge(var.tags, { Name = "acme-web-sg" })
}

# 2) Instância EC2
resource "aws_instance" "web" {
  # Ubuntu 22.04 LTS em us-east-1. Se mudar de região, ajuste a AMI.
  ami                    = "ami-053b0d53c279acc90"
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [aws_security_group.web.id]

  # Recria a EC2 quando o user_data mudar (ótimo para demo)
  user_data_replace_on_change = true

  # Script de inicialização (Ubuntu ou Amazon Linux 2)
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

    # Página HTML estilizada (usa var.demo_message)
    cat > /var/www/html/index.html <<'HTML'
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1" />
      <title>Terraform Demo</title>
      <style>
        :root { --accent:#00d4ff; --bg1:#0f2027; --bg2:#203a43; --bg3:#2c5364; }
        * { box-sizing: border-box }
        body {
          margin:0; min-height:100vh; display:grid; place-items:center;
          background:linear-gradient(135deg,var(--bg1),var(--bg2),var(--bg3));
          font-family: system-ui, -apple-system, Segoe UI, Roboto, Ubuntu, Arial, sans-serif;
          color:#e8f1f2;
        }
        .card {
          background: rgba(0,0,0,.45); backdrop-filter: blur(10px);
          padding: 44px 36px; border-radius: 20px; width: min(760px, 92vw);
          box-shadow: 0 12px 32px rgba(0,0,0,.35); border: 1px solid rgba(255,255,255,.08);
          text-align: center;
        }
        h1 { margin: 4px 0 10px; font-size: clamp(28px, 6vw, 44px); line-height: 1.1;
             color: var(--accent); text-shadow: 0 2px 16px rgba(0,212,255,.25); }
        p { margin:0; color:#c9d6df; font-size: clamp(14px, 2.2vw, 18px) }
        .badges { margin-top:16px; display:flex; gap:10px; flex-wrap:wrap; justify-content:center; }
        .badge {
          padding:6px 10px; border-radius:999px; background:rgba(255,255,255,.08);
          border:1px solid rgba(255,255,255,.12); font-size:12px;
        }
      </style>
    </head>
    <body>
      <div class="card">
        <h1>${var.demo_message}</h1>
        <p>Provisionado automaticamente com <strong>Terraform</strong> + <strong>AWS</strong>.</p>
        <div class="badges">
          <span class="badge">Workspace: acme-iac-migration</span>
          <span class="badge">Region: us-east-1</span>
        </div>
      </div>
    </body>
    </html>
    HTML
  EOF

  tags = merge(var.tags, { Name = "acme-web" })

  lifecycle {
    precondition {
      condition     = contains(keys(var.tags), "CostCenter")
      error_message = "Tag 'CostCenter' é obrigatória (enforced by module)."
    }
  }
}
