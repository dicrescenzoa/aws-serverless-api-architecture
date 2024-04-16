BUILD_DIR=${PWD}
ARTIFACTS_DIR=${PWD}/build

.PHONY: build
build:
	GOARCH=arm64 GOOS=linux go build -o ./build/bootstrap main.go

artifacts:
	cd $(ARTIFACTS_DIR) && zip -ry ${BUILD_DIR}/bootstrap.zip .

buildLambda: build artifacts