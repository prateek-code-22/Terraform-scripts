# key pair
resource aws_key_pair my_key {
    key_name = "${var.env}-terra-key-ec2"
    public_key = file("terra-key-ec2.pub")

    tags = {
        Environment = var.env
    }
}


# VPC & security group
resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "my_security_group"{
    name = "${var.env}-infra-sg"
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

    tags = {
        Name = "${var.env}-infra-sg"
    }
}

#EC2 instance
resource "aws_instance" "my_instance" {
   count = var.instance_count 
   
    depends_on = [ aws_security_group.my_security_group, aws_key_pair.my_key ]

    key_name = aws_key_pair.my_key.key_name
    security_groups = [aws_security_group.my_security_group.name]
    instance_type = var.instance_type  
    ami = var.ec2_ami 
    
    root_block_device {
        volume_size = var.env == "prod" ? 20 :10
         volume_type = "gp3"
    }
    tags = {
        Name = "${var.env}-EC2-Infra"
        Environment = var.env
    }
}

