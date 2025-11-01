# to install the provider using terraform
terraform  {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = ">= 6.0.0"
      }
    }

}