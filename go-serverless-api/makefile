BUILD_DIR=${PWD}
ARTIFACTS_DIR=${PWD}/build
DOCKER_IMAGE_NAME=go-serverless-api-docker
ECR_REPO_NAME=${project_name}-${environment}-go-serverless-api-repository

.PHONY: build
build:
	GOARCH=arm64 GOOS=linux go build -o ./build/bootstrap main.go

artifacts:
	cd $(ARTIFACTS_DIR) && zip -ry ${BUILD_DIR}/bootstrap.zip .

buildLambda: build artifacts

buildDocker:
	docker build -t ${DOCKER_IMAGE_NAME} .

ecrLogin:
	aws ecr get-login-password --region ${region} --profile ${aws_profile} | docker login --username AWS --password-stdin ${account_number}.dkr.ecr.${region}.amazonaws.com

pushDocker: ecrLogin
	docker tag ${DOCKER_IMAGE_NAME} ${account_number}.dkr.ecr.${region}.amazonaws.com/${ECR_REPO_NAME}:latest
	docker push ${account_number}.dkr.ecr.${region}.amazonaws.com/${ECR_REPO_NAME}:latest