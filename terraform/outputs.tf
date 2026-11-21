output "instance_id" {
  description = "ID of the Jenkins EC2 instance"
  value       = aws_instance.jenkins_server.id
}

output "public_ip" {
  description = "Public IP address of the Jenkins server"
  value       = aws_instance.jenkins_server.public_ip
}

output "jenkins_url" {
  description = "Jenkins web interface URL"
  value       = "http://${aws_instance.jenkins_server.public_ip}:8080"
}

output "application_url" {
  description = "Demo application URL"
  value       = "http://${aws_instance.jenkins_server.public_ip}:5000"
}