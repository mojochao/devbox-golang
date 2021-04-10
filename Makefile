#==============================================================================
#
# Makefile for building Docker images and pushing them to Docker Hub registries.
#
#==============================================================================

# Set app identity.
APP=devbox-golang
VERSION := $(shell cat VERSION | tr -d '\n')

# Set Docker configuration.
DOCKERFILE ?= Dockerfile
IMAGE = mojochao/$(APP)
TAG ?= $(VERSION)

#==============================================================================
#
# Define help targets with descriptions provided in trailing `##` comments.
#
# Note that the '## description' is used in generating documentation when 'make'
# is invoked with no arguments.
#
# See https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html for
# additional details on how this works.
#
#==============================================================================

.PHONY: help
help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

#==============================================================================
#
# Define docker targets.
#
#==============================================================================

.PHONY: docker-build
docker-build: ## Build docker image
	@echo 'building docker image $(IMAGE):latest'
	DOCKER_BUILDKIT=1 docker build -f $(DOCKERFILE) --progress=plain -t $(IMAGE):latest .

.PHONY: docker-tag
docker-tag: ## Tag built image with $TAG (default: VERSION)
	@echo 'tagging docker image $(IMAGE):$(TAG)'
	docker tag $(IMAGE):latest $(IMAGE):$(TAG)

.PHONY: docker-push
docker-push: ## Push image tags to Docker Hub
	@echo 'pushing docker image $(IMAGE):latest,$(TAG) to Docker Hub'
	docker push $(IMAGE):latest
	docker push $(IMAGE):$(TAG)
