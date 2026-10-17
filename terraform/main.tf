
resource "aws_vpc" "inventory" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "inventory-manager-vpc"
    Environment = "dev"
    Project     = "inventory-manager"
  }
}
resource "aws_internet_gateway" "inventory" {
  vpc_id = aws_vpc.inventory.id

  tags = {
    Name        = "inventory-manager-igw"
    Environment = "dev"
    Project     = "inventory-manager"
  }
}
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.inventory.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "inventory-manager-public-subnet"
    Environment = "dev"
    Project     = "inventory-manager"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.inventory.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.inventory.id
  }

  tags = {
    Name        = "inventory-manager-public-rt"
    Environment = "dev"
    Project     = "inventory-manager"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.inventory.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = false

  tags = {
    Name        = "inventory-manager-private-subnet"
    Environment = "dev"
    Project     = "inventory-manager"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.inventory.id

  tags = {
    Name        = "inventory-manager-private-rt"
    Environment = "dev"
    Project     = "inventory-manager"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}



resource "aws_security_group" "web" {
  name        = "inventory-manager-web-sg"
  description = "Security group for Inventory Manager web access"
  vpc_id      = aws_vpc.inventory.id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound IPv4 traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "inventory-manager-web-sg"
    Environment = "dev"
    Project     = "inventory-manager"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.web.id
  description       = "SSH from my current public IP"
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = "139.135.55.63/32"
}

resource "aws_instance" "web" {
  ami                         = "ami-0c02fb55956c7d316"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.web.id]
  key_name                    = "inventory-manager-key"
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    set -e

    amazon-linux-extras install nginx1 -y

    cat > /usr/share/nginx/html/index.html <<'HTML'
    <!DOCTYPE html>
    <html>
    <head>
      <title>Inventory Manager DevOps</title>
    </head>
    <body>
      <h1>Inventory Manager DevOps Project</h1>
      <p>Successfully deployed on AWS EC2!</p>
      <p>Infrastructure provisioned using Terraform.</p>
      <p>NGINX configured automatically using user_data.</p>
    </body>
    </html>
    HTML

    systemctl enable nginx
    systemctl start nginx
  EOF

  user_data_replace_on_change = true

  tags = {
    Name        = "inventory-manager-web"
    Environment = "dev"
    Project     = "inventory-manager"
  }
}
