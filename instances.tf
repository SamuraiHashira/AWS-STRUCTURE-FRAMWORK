data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.private_subnets.id
  vpc_security_group_ids = [aws_security_group.customers_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y httpd
              systemctl start httpd
              systemctl enable httpd

              TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
              INSTANCE_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id)

              cat <<HTML > /var/www/html/index.html
              <html>
              <body style="font-family: Arial; text-align: center; padding: 50px;">
                  <div style="border: 1px solid #ccc; padding: 20px; display: inline-block;">
                      <h1>Infrastructure is Online</h1>
                      <p>Managed by: <b>${var.admin_name}</b></p>
                      <p>Organization: <b>${var.organization_name}</b></p>
                      <hr>
                      <p>Instance ID: $INSTANCE_ID</p>
                  </div>
              </body>
              </html>
              HTML
              EOF

  tags = { Name = "${var.project_name}-master-server" }
}