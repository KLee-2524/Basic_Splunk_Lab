variable "aws_region" {
    description = "AWS region where resources will be deployed" 
    type        = string
    default     = "us-west-1"
}

variable "PRIVATE_KEY" {
    type      = string
    sensitive = true
}