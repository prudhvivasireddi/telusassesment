variable "tags_all" {
  type        = map(string)
  description = "Default tags applies to all resources"
  default = {
    Name    = "telus-assesment-terraform-backend"
    Purpose = "assesment"
  }
}
