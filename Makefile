.DEFAULT_GOAL:=help

ROOT_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

.PHONY: test-dbt-utils
test-dbt-utils: ## Runs integration tests for dbt-utils
	@\
	cd integration_tests/dbt_utils && \
	DBT_PROFILES_DIR=$(ROOT_DIR)devops dbt clean && \
	DBT_PROFILES_DIR=$(ROOT_DIR)devops dbt deps && \
	DBT_PROFILES_DIR=$(ROOT_DIR)devops dbt seed --full-refresh && \
	DBT_PROFILES_DIR=$(ROOT_DIR)devops dbt run --full-refresh && \
	DBT_PROFILES_DIR=$(ROOT_DIR)devops dbt test

.PHONY: test-dbt-date
test-dbt-date: ## Runs integration tests for dbt-date
	@\
	cd integration_tests/dbt_date && \
	DBT_PROFILES_DIR=$(ROOT_DIR)devops dbt clean && \
	DBT_PROFILES_DIR=$(ROOT_DIR)devops dbt deps && \
	DBT_PROFILES_DIR=$(ROOT_DIR)devops dbt seed --full-refresh && \
	DBT_PROFILES_DIR=$(ROOT_DIR)devops dbt run --full-refresh && \
	DBT_PROFILES_DIR=$(ROOT_DIR)devops dbt test

.PHONY: test-dbt-expectations
test-dbt-expectations: ## Runs integration tests for dbt-expectations
	@\
	cd integration_tests/dbt_expectations && \
	DBT_PROFILES_DIR=$(ROOT_DIR)devops dbt clean && \
	DBT_PROFILES_DIR=$(ROOT_DIR)devops dbt deps && \
	DBT_PROFILES_DIR=$(ROOT_DIR)devops dbt seed --full-refresh && \
	DBT_PROFILES_DIR=$(ROOT_DIR)devops dbt run --full-refresh && \
	DBT_PROFILES_DIR=$(ROOT_DIR)devops dbt test

.PHONY: test-dbt-audit-helper
test-dbt-audit-helper: ## Runs integration tests for dbt-audit-helper
	@\
	cd integration_tests/dbt_audit_helper && \
	DBT_PROFILES_DIR=$(ROOT_DIR)devops dbt clean && \
	DBT_PROFILES_DIR=$(ROOT_DIR)devops dbt deps && \
	DBT_PROFILES_DIR=$(ROOT_DIR)devops dbt seed --full-refresh && \
	DBT_PROFILES_DIR=$(ROOT_DIR)devops dbt run --full-refresh && \
	DBT_PROFILES_DIR=$(ROOT_DIR)devops dbt test

.PHONY: help
help: ## Show this help message.
	@echo 'usage: make [target]'
	@echo
	@echo 'targets:'
	@grep -E '^[7+a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
