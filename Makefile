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

KREPO_DESC = TriggerMesh - Event Sources Bundle

DIST_DIR  ?= $(CURDIR)/_output

# Rely on ko for building/publishing images and generating/deploying manifests
KO        ?= ko
KOFLAGS   ?=
IMAGE_TAG ?= $(shell git rev-parse HEAD)

.PHONY: help release clean

help: ## Display this help
	@awk 'BEGIN {FS = ":.*?## "; printf "\n$(KREPO_DESC)\n\nUsage:\n  make \033[36m<cmd>\033[0m\n"} /^[a-zA-Z0-9._-]+:.*?## / {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

release: ## Publish container images and generate release manifests
	@mkdir -p $(DIST_DIR)
	$(KO) resolve -f config/ -l 'triggermesh.io/crd-install' > $(DIST_DIR)/triggermesh-crds.yaml
	$(KO) resolve $(KOFLAGS) -t $(IMAGE_TAG) --tag-only -f config/ -l '!triggermesh.io/crd-install' > $(DIST_DIR)/triggermesh.yaml

clean: ## Clean release artifacts
	@$(RM) -rfv $(DIST_DIR)
