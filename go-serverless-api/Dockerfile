FROM golang:1.22-alpine AS build_base
RUN apk add --no-cache git
WORKDIR /tmp/gin

COPY . .
RUN go mod download
RUN GOARCH=arm64 GOOS=linux go build -o bootstrap .

FROM alpine:3.9
RUN apk add ca-certificates
COPY --from=public.ecr.aws/awsguru/aws-lambda-adapter:0.8.3 /lambda-adapter /opt/extensions/lambda-adapter
COPY --from=build_base /tmp/gin/bootstrap /app/bootstrap

EXPOSE 8000

CMD ["/app/bootstrap"]