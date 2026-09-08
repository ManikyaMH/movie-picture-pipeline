# Submission Checklist

Before submitting, confirm all of these:

- [ ] `.github/workflows/frontend-ci.yaml` exists and passes.
- [ ] `.github/workflows/backend-ci.yaml` exists and passes.
- [ ] `.github/workflows/frontend-cd.yaml` exists and passes.
- [ ] `.github/workflows/backend-cd.yaml` exists and passes.
- [ ] No AWS access key or secret key is committed anywhere.
- [ ] Frontend Docker image is visible in ECR repository `frontend`.
- [ ] Backend Docker image is visible in ECR repository `backend`.
- [ ] `kubectl get pods` shows frontend and backend running.
- [ ] Backend public URL + `/movies` shows the movie JSON.
- [ ] Frontend public URL shows the movie list.
- [ ] Screenshots are saved for CI, CD, backend output, and frontend output.
- [ ] Public GitHub repository link or ZIP is ready for Udacity submission.
- [ ] AWS resources are destroyed only after screenshots/evidence are saved.
