# Current AWS compatibility note

The original Udacity starter pinned EKS Kubernetes `1.25`, which can no longer be used to create a new EKS cluster. This project-ready copy updates the Terraform default to EKS `1.34`, uses an Amazon Linux 2023 managed node group, and uses AWS provider `5.100.0`. The ECR repository names (`frontend`, `backend`), EKS cluster name (`cluster`), and `github-action-user` remain the same as the course starter.

Run `terraform init` before `terraform apply`; a new `.terraform.lock.hcl` will be generated locally.

The Terraform also uses the modern EKS access-entry API to grant `github-action-user` cluster-admin access, so the legacy `setup/init.sh` mapping step is not required for a new cluster created from this copy.
