variable "env" {
    description = "This is the environment variable"
    type = string
}

variable "bucket_name" {
    description = "This is the bucket name"
    type = string
}

variable "instance_count" {
  description = "this is the number of instance count"
  type = number
}

variable "instance_type" {
  description = "This is the instance type for EC2 instance"
  type = string
}

variable "ec2_ami" {
  description = "This is the AMI id for EC2 instance"
  type = string
}

variable "hash_key" {
    description = "This is the hash key for dynamodb table"
    type = string
  
}