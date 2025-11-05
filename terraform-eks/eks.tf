module "eks" {
    # import the module template
    source = "terraform-aws-modules/eks/aws"
    version = "~> 21.0"

    # cluster info (control plane) 
    name               = local.name
    kubernetes_version = "1.31"
    endpoint_public_access = true

    # control plane network 
    vpc_id = module.vpc.vpc_id
    subnet_ids = module.vpc.private_subnets
    control_plane_subnet_ids = module.vpc.intra_subnets

    # 
    addons = {
        coredns                = {
            most_recent = true
        }
        kube-proxy             = {
            most_recent = true
        }
        vpc-cni                = {
            most_recent = true
        }
    }

    # nodes inside cluster
    eks_managed_node_groups = {
        my-cluster-ng = {
            instance_types = ["t2.micro"]
            attach_cluster_primary_security_group = true
            min_size = 1
            max_size = 2 
            desired_size = 1    

            capacity_type = "SPOT"
        }
    }


    tags = {
        Environment = local.env
        Terraform = "True"
    }
}