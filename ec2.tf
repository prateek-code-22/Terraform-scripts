# key pair
resource aws_key_pair my_key {
    key_name = "terra-key-ec2"
    public_key = file("terra-key-ec2.pub")
}


# VPC & security group
resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "my_security_group"{
    name = "automate-sg"
    description = "This will add a TF generated SG"
    vpc_id = aws_default_vpc.default.id  #interpolation 

    #inbound rule
    ingress{
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH Open"
    }

    ingress{
        from_port = 80
        to_port = 80  
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTP OPEN"
    }

    #outbound rule
    egress{
        from_port = 0
        to_port = 0
        protocol = -1    
        cidr_blocks = ["0.0.0.0/0"]
        description = "all access open outbound"
    }
}

#EC2 instance
resource "aws_instance" "my_instance" {
   # count = 2 # meta argument - to create 2 instance 
    for_each =  tomap({
        automate_micro = "t2.micro",
        automate_medium = "t2.micro",
    })

    depends_on = [ aws_security_group.my_security_group, aws_key_pair.my_key ]

    key_name = aws_key_pair.my_key.key_name
    security_groups = [aws_security_group.my_security_group.name]
    instance_type = var.ec2_instance_type  #using the variable value
    # instance_type = each.values  #using the foreach value
    ami = var.ec2_ami 
    user_data = file("install_nginx.sh") #to run sh at cold start of ec2

    root_block_device {
        volume_size = var.env == "prod" ? 20 : var.ec2_default_root_storage_size
         volume_type = "gp3"
    }
    tags = {
        Name = "EC2-Terra"
    }
}


resource "aws_instance" "new_instance" {
    ami = "unknown"
    instance_type = "unknown"
}