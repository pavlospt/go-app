# Deploying sample cluster

In this directory we include Terraform files that deploy a test GKE cluster on GCP.
We will use this cluster in order to deploy our sample Go application through Helm.

## Usage

In order to deploy your own GKE cluster you need to define (in a `.tfvars` file if you want), 
the following variables: 

```shell
project_id = ""
region     = ""
zone       = ""
```

After defining the above we can proceed with `terraform init && terraform apply`. This will deploy 
a GCP VPC and a GKE cluster with 1 node.

For the sake of simplicity we won't deal with Terraform state management! 
