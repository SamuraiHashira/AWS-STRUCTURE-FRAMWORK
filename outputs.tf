output "website_url" {
  value       = "http://${aws_lb.nexus_alb.dns_name}"
  description = "The public URL to access the application"
}

output "vpc_id" {
  value = aws_vpc.main.id
}