output "lab_instances" {
    value = {
        for attendee, mod in module.splunk-lab :
        attendee => {
            splunk_name   = module.splunk-lab["${attendee}"].splunk_details.name
            splunk_pri_ip = module.splunk-lab["${attendee}"].splunk_details.pri_ip
            splunk_pub_ip = module.splunk-lab["${attendee}"].splunk_details.pub_ip
        }
    }
}