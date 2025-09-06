variable "attendee_number" {
    description = "Used to create a separate subnet for each individual attendee"
    type        = string
    default     = "24"
}

variable "vpc_id" {
    description = "ID of the lab vpc"
    type        = string
}

variable "route_table_id" {
    description = "ID of the route table"
    type        = string
}

variable "instance_type" {
  description = "Type of EC2 instance to provision"
  default     = "t2.medium"
}

variable "availability_zone" {
    description = "AWS availability zone where resources will be deployed"
    type        = string
    default     = "us-west-1a" 
}

variable "splunk_ami" {
    description = "AMI of the Splunk Ubuntu VM to deploy"
    type        = string
    default     = "ami-043b59f1d11f8f189"

    # WinSer22 = "ami-06fe666da1b90024e"
    # WinSer16 = "ami-09896dc1e97cae396"
    # Ubuntu 22.04 = "ami-043b59f1d11f8f189"
}

variable "splunk_setup_script" {
    description = "Set script to configure Target VM upon deployment"
    type        = string
    default     = <<-EOT
    #!/bin/bash
    export DEBIAN_FRONTEND=noninteractive

    mkdir /home/ubuntu/FAST
    echo "FAST directory created" > /home/ubuntu/FAST/setup_log.txt

    apt update -y
    echo "apt update initiated" >> /home/ubuntu/FAST/setup_log.txt

    sudo wget -O splunk-9.3.0-51ccf43db5bd-linux-2.6-amd64.deb "https://download.splunk.com/products/splunk/releases/9.3.0/linux/splunk-9.3.0-51ccf43db5bd-linux-2.6-amd64.deb" 
    echo "Splunk download initiated" >> /home/ubuntu/FAST/setup_log.txt

    sudo dpkg -i splunk-9.3.0-51ccf43db5bd-linux-2.6-amd64.deb
    echo "Splunk installation initiated" >> /home/ubuntu/FAST/setup_log.txt

    cd /opt/splunk/bin
    echo "Location set to Splunk binaries directory" >> /home/ubuntu/FAST/setup_log.txt

    sudo ./splunk enable boot-start --accept-license
    FASTsplunk
    FASTPassword01
    FASTPassword01
    echo "Splunk configured to start on boot and user account created" >> /home/ubuntu/FAST/setup_log.txt

    sudo ./splunk start
    echo "Splunk started" >> /home/ubuntu/FAST/setup_log.txt
    EOT
}