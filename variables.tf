variable "name" {
  description = "Name of the resources to be created"
  type        = string
  default     = "telus"
}

variable "ami_id" {
  description = "AMI ID of the EC2 instance"
  type        = string
  default     = "ami-0654ca17e4d49cdb4"
}

variable "instance_type" {
  description = "Instance type of the EC2 instance"
  type        = string
  default     = "t2.medium"
}

variable "tags_all" {
  description = "Map of tags which applies to all the resources"
  type        = map(string)
  default = {
    "Name"    = "Telus"
    "Purpose" = "Assesment"
  }
}