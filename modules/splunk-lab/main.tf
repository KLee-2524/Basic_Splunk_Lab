resource "aws_subnet" "FAST-subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = "192.168.${var.attendee_number}.0/28"
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "FAST-subnet-${var.attendee_number}"
  }
}

resource "aws_route_table_association" "FAST-subnet" {
  subnet_id      = aws_subnet.FAST-subnet.id
  route_table_id = var.route_table_id
}

# SECURITY GROUP #
resource "aws_security_group" "FAST-sg" {
  name   = "FAST-sg-${var.attendee_number}"
  vpc_id = var.vpc_id

  # SHH
  ingress {
    from_port   = 22
    to_port     = 22
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

resource "aws_instance" "splunk-vm" {
  ami           = var.splunk_ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.FAST-subnet.id

  private_ip = "192.168.${var.attendee_number}.10"
  
  vpc_security_group_ids = [aws_security_group.FAST-sg.id]

  key_name = "terraform-key-pair"

  provisioner "file" {
    content     = file("/modules/splunk-lab/splunk.sh.tpl")
    destination = "/home/ubuntu/splunk.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/splunk.sh",
      "TEST_VAR=${TEST_VAR} /home/ubuntu/splunk.sh"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = var.PRIVATE_KEY
      host        = self.public_ip
    }

  }

  tags = {
    Name = "Splunk-VM-${var.attendee_number}-${var.attendee_name}"
  }
}
