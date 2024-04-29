# aws-serverless-api-architecture

## Overview
This repository contains the code for the AWS Serverless API Architecture blog post. 

## Prerequisites

- AWS Account
- AWS CLI
- Node 20.10.0
- Go 1.22.1
- Terraform 1.5.5
- Docker

## fastify-serverless-api
This directory contains the code of a simple Fastify API service.

1. install dependencies with `npm install`
2. for running locally run `npm run dev`
3. for building the project run `npm run build`
4. for starting the build run `npm run start`

## go-serverless-api
This directory contains the code of a simple Go Gin API service.

1. for running locally run `go run main.go`
2. for building the project run `go build`
3. for starting the build run `./build/bootstrap` (if the build fail to run check the Makefile to adapt the build to your local machine)

## Deploy
1. Under terraform folder rename [.example.env](terraform%2F.example.env) to .env and fill in the required values.
2. Run the following commands to deploy the infrastructure:
```bash
cd terraform
make create-all
```

3. To deploy a new lambda version run:
```bash
make create-infra
```

Note: this will create 3 lambda:
- [fastify-serverless-api-lambda (ZIP)](terraform%2Finfra%2Flambda%2Ffastify-serverless-api-lambda)
- [go-serverless-api-lambda(ZIP)](terraform%2Finfra%2Flambda%2Fgo-serverless-api-lambda)
- [go-serverless-api-lambda-docker(docker)](terraform%2Finfra%2Flambda%2Fgo-serverless-api-lambda-docker)

3. To destroy all infrastructure run:
```bash
make destroy-all
```

## Commands
- `make create-all`: Create all infrastructure
- `make create-infra`: Create only the lambda infrastructure and update the api gateway
- `make create-base`: Create the base infrastructure like terraform state resources and ecr for the docker lambda
- `make destroy-all`: Destroy all infrastructure
- `make destroy-infra`: Destroy only the lambda infrastructure and api gateway
- `make destroy-base`: Destroy the base infrastructure 