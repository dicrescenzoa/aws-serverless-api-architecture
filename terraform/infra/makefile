# Makefile

.PHONY: tf-init
tf-init:
	terraform init \
	-var environment=${environment} \
	-var region=$(region) \
	-var account_number=$(account_number) \
	-var project_name=$(project_name) \
	-backend-config='bucket=terraform-state-$(project_name)-$(environment)' \
	-backend-config='key=tfstate/$(project_name)-$(environment).tfstate' \
	-backend-config='region=$(region)' \
	-backend-config='dynamodb_table=terraform-state-lock-$(project_name)-$(environment)' \
	-backend-config='encrypt=true'


.PHONY: tf-plan
tf-plan:
	terraform plan \
	-var environment=${environment} \
	-var region=$(region) \
	-var account_number=$(account_number) \
	-var project_name=$(project_name) \
	-out=tfplan

.PHONY: tf-apply
tf-apply:
	terraform apply tfplan

.PHONY: tf-destroy
tf-destroy:
	terraform destroy \
	-var environment=${environment} \
	-var region=$(region) \
	-var account_number=$(account_number) \
	-var project_name=$(project_name) \
	-auto-approve