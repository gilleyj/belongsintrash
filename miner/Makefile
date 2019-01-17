.DEFAULT_GOAL := help

ORG = lacquerlabs
NAME = miner
IMAGE = $(ORG)/$(NAME)
VERSION = 0.0.1

build: ## Build it
	docker build -t $(IMAGE):latest .

buildnocache: ## Build it without using cache
	docker build --no-cache -t $(IMAGE):latest .

tag: ## Tag it with $(VERSION)
	docker tag $(IMAGE):latest $(IMAGE):$(VERSION)

run: ## run it attached
	docker run --name $(NAME)_run --rm -it $(IMAGE) /bin/sh

kill: ## kill it
	docker kill $(NAME)_run

release: tag ## Create and push release to docker hub
	@if ! docker images $(IMAGE) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker push $(IMAGE)
	@echo "*** Don't forget to create a tag. git tag rel-$(VERSION) && git push origin rel-$(VERSION)"

.PHONY: help

help: ## Helping devs since 2016
	@cat $(MAKEFILE_LIST) | grep -e "^[a-zA-Z_\-]*: *.*## *" | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo "For additional commands have a look at the README"
