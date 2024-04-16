BUILD_DIR=${PWD}
ARTIFACTS_DIR=${PWD}/build

install:
	rm -rf node_modules
	npm install

build:
	npm run build

artifacts:
	cp run.sh $(ARTIFACTS_DIR)
	cd $(ARTIFACTS_DIR) && zip -ry ${BUILD_DIR}/bootstrap.zip .

buildLambda: install build artifacts