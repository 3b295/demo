FROM golang:1.16 as builder

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -ldflags "-s -w -extldflags '-static' " -o demo .

FROM alpine:3.15.0 as runner

WORKDIR /app

COPY --from=builder /app/demo .

EXPOSE 80

ENTRYPOINT ["./demo"]
