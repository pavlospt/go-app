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

build_docker_image:
	docker buildx build --platform linux/amd64,linux/arm64 --tag pavlospt/go-app:$(DOCKER_TAG) --push .

sign_docker_image:
	cosign sign $(REPOSITORY) $(WORKFLOW) $(REF) pavlospt/go-app:$(DOCKER_TAG)
