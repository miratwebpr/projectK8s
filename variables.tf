variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Availability zones for our instances and VPC"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "ami_id" {
    type = string
    default = "ami-0c7217cdde317cfec"
}

variable "instance" {
    type = string
    default = "t3.medium"
}