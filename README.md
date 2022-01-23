# Go application

This repository contains a sample Go app through its full lifecycle.

* Code
* Containerization
* Helm package
* Cluster deployment
* Supporting CI/CD workflows

## PR Workflow

This workflow is executing on every PR checks our Go code for linting issues and only if there are 
changes on `*.go` files, since our pipeline is not taking any actions unrelated to the application.

_No tests are added at this stage since there is no "serious" functionality to be tested for._

After that we build a multiplatform Docker image by using QEMU & Buildx. Our Docker image is then 
pushed to DockerHub with the branch name as Docker tag.

Finally we sign our image using [cosign](https://github.com/sigstore/cosign) and its public Fulcio 
instance, which allows us to use ephemeral certificates.

## Main workflow

This workflow is executing when a new commit is pushed on `main` branch.

This workflow is following the same steps as the above workflow (except for linting, since this is covered by PR workflow),
but pushes a Docker image on DockerHub with the `main` tag.

## Tag workflow

This workflow is executing when a new `tag` is pushed on our branch.

In addition to the Main workflow, this one packages our Helm chart and after that it deploys it on our sample cluster
by using a `KUBECONFIG`.

The `KUBECONFIG` environment variable is added after authenticating with GCP by using 
[Workload Identity Provider](https://cloud.google.com/blog/products/identity-security/enabling-keyless-authentication-from-github-actions), which allows us for keyless authentication.

In parallel we create a new Github release that includes a `.tgz` archive of our Helm package.

### Local testing

In order to test our Go application locally we can use `docker compose up`. 
