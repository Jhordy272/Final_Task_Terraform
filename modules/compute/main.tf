# Creates an EC2 instance in AWS
resource "aws_instance" "instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.aws_subnet_id
  vpc_security_group_ids = var.aws_security_group_ids
  count                  = var.instance_count
  key_name               = null

  user_data = <<-EOF
            #!/bin/bash
            sudo yum install -y httpd
            echo "Hello from ${count.index}" | sudo tee /var/www/html/index.html
            sudo systemctl start httpd
            sudo systemctl enable httpd
            EOF

  tags = {
    Name = "Instance-${count.index}"
  }
}
