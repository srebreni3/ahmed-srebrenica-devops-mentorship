resource "aws_security_group" "web_server_sg" {
  name        = "task-12-web-server-sg"
  description = "Security group for web server"
  
  vpc_id = "vpc-0bfdf441ab6b894d2"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  }

resource "aws_security_group" "db_server_sg" {
  name        = "task-12-db-server-sg"
  description = "Security group for DB server"
  
  vpc_id = "vpc-0bfdf441ab6b894d2"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "WebServer" {
  ami           = "ami-07155ccdc46d1ded2"
  instance_type = "t2.micro"
  key_name      = "ahmed-srebrenica-web-server-key"
  vpc_security_group_ids = [aws_security_group.web_server_sg.id]

  tags = {
    Name = "task-12-web-server-tf"
    CreatedBy = "ahmed.srebrenica"
    Project = "task-12"
    IaC = "Terraform"
  }
}

resource "aws_instance" "DBServer" {
  ami           = "ami-07155ccdc46d1ded2"
  key_name      = "ahmed-srebrenica-web-server-key"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.db_server_sg.id]

  tags = {
    Name = "task-12-db-server-tf"
    CreatedBy = "ahmed.srebrenica"
    Project = "task-12"
    IaC = "Terraform"
  }
}

