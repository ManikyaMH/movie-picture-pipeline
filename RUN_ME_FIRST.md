# Run Me First

This project starts from the exact Udacity `cd12354-Movie-Picture-Pipeline` starter ZIP you uploaded. The frontend and backend source files are unchanged. The project adds the four required GitHub Actions workflows, local Docker Compose support, and current AWS/EKS compatibility updates.

## 1. Test it locally in VS Code

Requirement: Docker Desktop must be installed and running.

From the project root in PowerShell:

```powershell
./run-local.ps1
```

Or:

```powershell
docker compose up --build
```

Open:

- Frontend: http://localhost:3000
- Backend API: http://localhost:5000/movies

Stop with `Ctrl+C`, then optionally run:

```powershell
docker compose down
```

## 2. Create an EMPTY GitHub repository

Create a new public GitHub repository with default branch `main`, but do not push this project yet. This avoids the CD workflows running before AWS is ready.

## 3. Create the AWS resources

Use the AWS account supplied for the course. Configure your administrator AWS credentials locally, then run:

```bash
cd setup/terraform
terraform init
terraform apply
```

Review the plan and type `yes`.

The Terraform creates:

- ECR repository `frontend`
- ECR repository `backend`
- EKS cluster `cluster`
- IAM user `github-action-user`
- EKS access for `github-action-user`

The original Udacity `setup/init.sh` is kept for reference, but the updated Terraform grants EKS access through the current access-entry API, so you do not need to run `init.sh` for a fresh cluster created by this copy.

Optional verification:

```bash
aws eks update-kubeconfig --name cluster --region us-east-1
kubectl get nodes
```

## 4. Create an access key for `github-action-user`

In AWS IAM, open `github-action-user` -> **Security credentials** -> **Create access key** -> **Application running outside AWS**.

Copy the access key ID and secret access key. Do not save them inside this project.

## 5. Add GitHub Secrets BEFORE pushing the project

In the empty GitHub repository:

**Settings -> Secrets and variables -> Actions -> New repository secret**

Create:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

## 6. Push this project to GitHub

From the project root:

```bash
git init
git add .
git commit -m "Movie Picture Pipeline project"
git branch -M main
git remote add origin YOUR_GITHUB_REPOSITORY_URL
git push -u origin main
```

Because the first push contains both frontend and backend code, the CD workflows will start automatically. The frontend workflow waits for the backend LoadBalancer if necessary.

## 7. Check the four workflows

The required files are:

- `.github/workflows/frontend-ci.yaml`
- `.github/workflows/backend-ci.yaml`
- `.github/workflows/frontend-cd.yaml`
- `.github/workflows/backend-cd.yaml`

The CD workflows run on pushes to `main` and can also be run manually.

The CI workflows run on pull requests to `main` and can also be run manually.

For CI proof, create a branch, make a harmless change under the relevant application folder, push the branch, and open a pull request to `main`.

## 8. First deployment order if you run workflows manually

Run **Backend Continuous Deployment** first. Wait until the backend LoadBalancer address appears. Then run **Frontend Continuous Deployment**.

The frontend workflow automatically reads the backend public LoadBalancer address and passes it to the Docker build as `REACT_APP_MOVIE_API_URL`.

You may optionally override it with a GitHub Actions repository variable named `REACT_APP_MOVIE_API_URL`.

## 9. Capture submission evidence

Save screenshots showing:

1. Frontend CI passing.
2. Backend CI passing.
3. Frontend CD passing.
4. Backend CD passing.
5. Backend public URL with `/movies` returning the movie JSON.
6. Frontend public URL displaying the movie list.

Submit the public GitHub repository link or the ZIP, depending on what Udacity asks for.

## 10. Destroy AWS resources only after screenshots

```bash
cd setup/terraform
terraform destroy
```

Type `yes` when prompted.

## If you previously saw a uWSGI build error
This v2 package pins the backend Docker base image to `python:3.10-alpine3.17`, which is compatible with the starter project's old `uWSGI==2.0.21` lockfile. Rebuild cleanly with:

```powershell
docker compose down
docker compose build --no-cache
docker compose up
```
