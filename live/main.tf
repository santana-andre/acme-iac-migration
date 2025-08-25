module "network" {
  source     = "../modules/network"
  cidr_block = var.cidr_block
  tags       = var.global_tags
}

module "compute" {
  source           = "../modules/compute"
  vpc_id           = module.network.vpc_id
  public_subnet_id = module.network.public_subnet_id
  instance_type    = "t2.micro"
  tags             = var.global_tags
  demo_message      = var.demo_message
  user_data        = <<-EOF
                      #!/bin/bash
                      yum update -y
                      yum install -y httpd
                      echo "Hello ACME - IaC OK" > /var/www/html/index.html
                      systemctl enable httpd --now
                      EOF
}
