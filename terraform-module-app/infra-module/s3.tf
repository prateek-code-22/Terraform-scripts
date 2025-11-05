resource "aws_s3_bucket" "remote4616871" {
    bucket = "${var.env}_${var.bucket_name}"
    
    tags = {
      Name = "${var.env}_${var.bucket_name}"
      Environment = var.env   
    }
}