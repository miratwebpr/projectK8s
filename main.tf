provider "aws" {
  region = var.region
}

locals {
  cluster_name = "project-eks-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length = 8
  special = false
}














































