# --- root/variables.tf

variable "aws_region" {
  default = "eu-north-1"
  //default = "us-west-2"
}

variable "access_ip" {
  type = string
}

variable "dbname" {
  type = string
}

variable "dbuser" {
  type      = string
  sensitive = true
}

variable "dbpassword" {
  type      = string
  sensitive = true
}