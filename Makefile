IMAGE ?= claude-code
TAG ?= latest
USER_UID ?= $(shell id -u)
USER_GID ?= $(shell id -g)
USERNAME ?= $(shell whoami)

build:
	docker build \
		--build-arg USER_UID=$(USER_UID) \
		--build-arg USER_GID=$(USER_GID) \
		--build-arg USERNAME=$(USERNAME) \
		-t $(IMAGE):$(TAG) .

.PHONY: build
