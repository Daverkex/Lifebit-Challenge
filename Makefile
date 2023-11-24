# A Self-Documenting Makefile: http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html

# Add the ability to override some variables
# Use with care
-include override.mk

# IaC
.PHONY: fmt check clean deploy-common deploy-app deploy-all get-dns
fmt: ## Format IaC code
	@cd IaC && terragrunt hclfmt
	@cd IaC && terraform fmt --recursive

check: ## Check IaC code
	@cd IaC && terragrunt hclfmt --terragrunt-check
	@cd IaC && terraform fmt --recursive --check

clean: ## Clean project temporal files
	@find . -type d -name ".terragrunt-cache" -prune -print -exec rm -rf {} \;
	@find . -type d -name ".terraform" -prune -print -exec rm -rf {} \;

deploy-common: ## Deploy common IaC
	@terragrunt run-all apply --terragrunt-non-interactive --terragrunt-working-dir IaC/Environments/production/eu-west-1/Common

deploy-app: ## Deploy the necessary infra for the application
	@terragrunt run-all apply --terragrunt-non-interactive --terragrunt-working-dir IaC/Environments/production/eu-west-1/Challenge

deploy-all: deploy-common deploy-app ## Deploy all the IaC

get-dns: ## Get the DNS for the application
	@terragrunt output "alb_public_url" --terragrunt-working-dir IaC/Environments/production/eu-west-1/Challenge/ECS-cluster


# Terraform auto documentation
.PHONY: gen-tf-doc
gen-tf-doc: ## Generate Terraform documentation
	@find IaC/Modules -type f -name "*.tf" -not -path "*/.terraform/*" -exec dirname  "{}" \; | sort -u | xargs -L1 terraform-docs markdown table


# Load test
.PHONY: load-test
load-test: ## Run K6 for load testing
	k6 run app/test/http_get.js


# Add custom targets here
-include custom.mk


# Self documentation
.PHONY: list
list: ## List all make targets
	@${MAKE} -pRrn : -f $(MAKEFILE_LIST) 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' \
		| egrep -v -e '^[^[:alnum:]]' -e '^$@$$' | sort

.PHONY: help
.DEFAULT_GOAL := help
help: ## List all make targets and descriptions
	@grep -h -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'
