# dev infrastructure
module "dev-infra" {
  source = "./infra-module"
  env = "dev"
  bucket_name = "bucket1448564"
  instance_count = 1
  instance_type = "t2.micro"
  ec2_ami = "ami-0ecb62995f68bb549"
  hash_key = "studentID"
}

