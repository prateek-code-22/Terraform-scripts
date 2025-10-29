variable "ec2_instance_type" {
    default = "t2.micro"
    type = string
}

variable "ec2_default_root_storage_size" {
    default = 10
    type = number
}

variable "ec2_ami" {
    default = "ami-0360c520857e3138f" #ubuntu 24.02
    type = string
}

variable "env" {
    default = "dev"
    type = string
}
