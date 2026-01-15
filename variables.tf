variable "region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name of the project/client"
  default     = "Cloud-Project"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "admin_name" {
  description = "Name of the administrator shown on the web page"
  default     = "Administrator"
}

variable "organization_name" {
  description = "Name of the organization"
  default     = "Cloud Operations Team"
}