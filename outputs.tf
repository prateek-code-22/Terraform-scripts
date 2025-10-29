# output for count

# output "ec2_public_ip" {
#     value = aws_instance.my_instance[*].public_ip #for multiple instance
# }

# output "ec2_public_dns" {
#     value = aws_instance.my_instance[*].public_dns #single output
# }

# output "ec2_private_ip" {
#     value = aws_instance.my_instance[*].private_ip
# }


# output for each
output "ec2_public_ips" {
    value = [
        for key in aws_instance.my_instance: key.public_ip
    ]
  
}