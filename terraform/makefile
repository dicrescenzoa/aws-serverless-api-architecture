# Makefile

# Include the .env file by converting it to makefile syntax
-include .env
export


.PHONY: create-base
create-base:
	cd base && make tf-init && make tf-plan && make tf-apply

.PHONY: destroy-base
destroy-base:
	cd base && make tf-destroy

.PHONY: create-infra
create-infra:
	cd infra && make tf-init && make tf-plan && make tf-apply

.PHONY: destroy-infra
destroy-infra:
	cd infra && make tf-destroy

.PHONY: destroy-all
destroy-all:
	make destroy-infra && make destroy-base

.PHONY: create-all
create-all:
	make create-base && make create-infra


