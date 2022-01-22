FROM golang:1.17.0 as builder
ENV GOOS linux
ENV CGO_ENABLED 0
WORKDIR /app
COPY /app/go.mod /app/go.sum ./
RUN go mod download
COPY /app .
RUN go build -o app

FROM alpine:3.15 as main
RUN apk add --no-cache ca-certificates
COPY --from=builder app .
CMD ./app
