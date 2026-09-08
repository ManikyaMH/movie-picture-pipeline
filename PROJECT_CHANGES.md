# Changes from the official Udacity starter

The application source under `starter/frontend` and `starter/backend` is unchanged from the ZIP supplied by the user.

Added for the project submission:

- `.github/workflows/frontend-ci.yaml`
- `.github/workflows/backend-ci.yaml`
- `.github/workflows/frontend-cd.yaml`
- `.github/workflows/backend-cd.yaml`
- `docker-compose.yml`
- `run-local.ps1`
- `run-local.sh`
- `RUN_ME_FIRST.md`
- `SUBMISSION_CHECKLIST.md`

Infrastructure compatibility updates:

- EKS default updated from the obsolete Kubernetes 1.25 to 1.34.
- Node group updated to Amazon Linux 2023.
- AWS provider updated to 5.100.0.
- Public/private EKS subnet discovery tags added.
- EKS access-entry resources grant `github-action-user` cluster-admin access, replacing the need to edit `aws-auth` manually for a fresh cluster.
- The starter's empty `terraform.tfstate` and old provider lock file are not included; Terraform regenerates local state/lock files.
- Unused CodeBuild resources with the starter placeholder repository URL were removed because this project deploys through GitHub Actions.

## Compatibility fix (v2)
- Pinned the backend base image to `python:3.10-alpine3.17` because the original unpinned `python:3.10-alpine` now resolves to a newer Alpine/GCC toolchain that fails to compile the starter project's locked `uWSGI==2.0.21`.
