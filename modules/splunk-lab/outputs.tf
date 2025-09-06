output "splunk_details" {
    value = {
        name = aws_instance.splunk-vm.tags["Name"]
        pri_ip = aws_instance.splunk-vm.private_ip
        pub_ip = aws_instance.splunk-vm.public_ip
    }
    description = "Splunk EC2 instance details"
}

output "attendee_number" {
    value = {
        attendee_number = var.attendee_number
    }
}