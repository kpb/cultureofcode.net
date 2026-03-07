#!/usr/bin/make
#
# Build, test, and deploy Culture of Code

BUILD_DIR = public

.DEFAULT_GOAL := help

.PHONY: check-deploy-vars
check-deploy-vars: ## Ensure deploy vars have been set
	@[ "${DEPLOY_USER}" ] || ( echo ">> DEPLOY_USER is not set"; exit 1 )
	@[ "${DEPLOY_HOST}" ] || ( echo ">> DEPLOY_HOST is not set"; exit 1 )

.PHONY: build
build: ## Build the site.
	hugo

.PHONY: lint
lint: ## Run local formatting/lint checks.
	npm run format:check
	npm run toml:check

.PHONY: format
format: ## Auto-format supported files.
	npm run format
	npm run toml:format

.PHONY: try
try: ## Build the site and run a local server on localhost:1313.
	hugo server --watch

.PHONY: deploy
deploy: check-deploy-vars build ## Build and deploy site to production web server.
	rsync -avz --exclude-from .rsyncignore -e ssh --delete $(BUILD_DIR)/ $(DEPLOY_USER)@$(DEPLOY_HOST):cultureofcode.net

# clean up the build
.PHONY: clean
clean: ## Delete build and local dependency artifacts
	rm -rf $(BUILD_DIR) node_modules

# Thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help: ## Display help message.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'
# add | sort | before | awk... for alphabetical order
