IMAGE ?= claude-code
TAG ?= latest
USER_UID ?= $(shell id -u)
USER_GID ?= $(shell id -g)
USERNAME ?= $(shell whoami)
TZ ?= $(shell cat /etc/timezone 2>/dev/null || echo Europe/Warsaw)

build:
	docker build \
		--build-arg USER_UID=$(USER_UID) \
		--build-arg USER_GID=$(USER_GID) \
		--build-arg USERNAME=$(USERNAME) \
		--build-arg TZ=$(TZ) \
		-t $(IMAGE):$(TAG) .

.PHONY: build
