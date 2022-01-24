ifdef BRANCH_NAME
DOCKER_TAG:=$(BRANCH_NAME)
else
DOCKER_TAG:=$(TAG_NAME)
endif

ifdef GITHUB_WORKFLOW
WORKFLOW:=-a workflow="$(GITHUB_WORKFLOW)"
else
WORKFLOW:= 
endif

ifdef GITHUB_REPOSITORY
REPOSITORY:=-a repository=$(GITHUB_REPOSITORY)
else
REPOSITORY:= 
endif

ifdef GITHUB_SHA
REF:=-a ref=$(GITHUB_SHA)
else
REF:= 
endif

HELM_VERSION:=$(TAG_NAME)

build_docker_image:
	docker buildx build --platform linux/amd64,linux/arm64 --tag pavlospt/go-app:$(DOCKER_TAG) --push .

sign_docker_image:
	cosign sign $(REPOSITORY) $(WORKFLOW) $(REF) pavlospt/go-app:$(DOCKER_TAG)

# Not including any guards for the sake of simplicity
# We will always assume that TAG_NAME is set when executing this command
helm_package:
	helm package go-app-charts -d go-app-charts/charts --app-version $(HELM_VERSION) --version $(HELM_VERSION)

helm_install:
	helm upgrade --install --force --create-namespace -n devops-challenge --set image.tag=$(DOCKER_TAG) --kubeconfig $(KUBECONFIG) go-app ./go-app-charts/charts/go-app-$(HELM_VERSION).tgz
