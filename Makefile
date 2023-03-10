# Copyright 2021 TriggerMesh Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

KREPO      = triggermesh-event-sources-bundle
KREPO_DESC = TriggerMesh - Event Sources Bundle

BASE_DIR          ?= $(CURDIR)
OUTPUT_DIR        ?= $(BASE_DIR)/_output
BIN_OUTPUT_DIR    ?= $(OUTPUT_DIR)
DIST_DIR          ?= $(OUTPUT_DIR)

# Dynamically generate the list of commands based on the directory name cited in the cmd directory
COMMANDS          := $(notdir $(wildcard cmd/*))

# Rely on ko for building/publishing images and generating/deploying manifests
KO                ?= ko
KOFLAGS           ?=
IMAGE_TAG         ?= $(shell git rev-parse HEAD)

# Go build variables
GO                ?= go
GOFMT             ?= gofmt

GOPKGS             = ./cmd/...

LDFLAGS            = -w -s
LDFLAGS_STATIC     = $(LDFLAGS) -extldflags=-static

SED               := sed -i
TAG_REGEX         := ^v([0-9]{1,}\.){2}[0-9]{1,}$

.PHONY: help all release fmt fmt-test clean clean

all: build

help: ## Display this help
	@awk 'BEGIN {FS = ":.*?## "; printf "\n$(KREPO_DESC)\n\nUsage:\n  make \033[36m<cmd>\033[0m\n"} /^[a-zA-Z0-9._-]+:.*?## / {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: $(COMMANDS)  ## Build all artifacts

$(COMMANDS): ## Build artifact
	$(GO) build -ldflags "$(LDFLAGS_STATIC)" -o $(BIN_OUTPUT_DIR)/$@ ./cmd/$@

release: ## Publish container images and generate release manifests
	@mkdir -p $(DIST_DIR)
	$(KO) resolve -f config/ -l 'triggermesh.io/crd-install' > $(DIST_DIR)/triggermesh-crds.yaml
ifeq ($(shell echo ${IMAGE_TAG} | egrep "${TAG_REGEX}"),${IMAGE_TAG})
	$(KO) resolve $(KOFLAGS) -B -t latest -f config/ -l '!triggermesh.io/crd-install' > /dev/null
endif
	$(KO) resolve $(KOFLAGS) -B -t $(IMAGE_TAG) --tag-only -f config/ -l '!triggermesh.io/crd-install' > $(DIST_DIR)/triggermesh.yaml

fmt: ## Format source files
	$(GOFMT) -s -w $(shell $(GO) list -f '{{$$d := .Dir}}{{range .GoFiles}}{{$$d}}/{{.}} {{end}} {{$$d := .Dir}}{{range .TestGoFiles}}{{$$d}}/{{.}} {{end}}' $(GOPKGS))

fmt-test: ## Check source formatting
	@test -z $(shell $(GOFMT) -l $(shell $(GO) list -f '{{$$d := .Dir}}{{range .GoFiles}}{{$$d}}/{{.}} {{end}} {{$$d := .Dir}}{{range .TestGoFiles}}{{$$d}}/{{.}} {{end}}' $(GOPKGS)))

clean: ## Clean build artifacts
	@$(RM) -v $(DIST_DIR)/triggermesh-crds.yaml $(DIST_DIR)/triggermesh.yaml
	@$(RM) -v $(TEST_OUTPUT_DIR)/$(KREPO)-c.out $(TEST_OUTPUT_DIR)/$(KREPO)-unit-tests.xml
	@$(RM) -v $(COVER_OUTPUT_DIR)/$(KREPO)-coverage.html
