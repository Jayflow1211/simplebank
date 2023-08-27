# Build stage
FROM golang:1.20.7-alpine3.18 AS builder
WORKDIR /app
COPY . .
RUN GOPROXY=https://goproxy.io,direct go build -o main main.go
EXPOSE 8080
CMD ["/app/main"]

# Run stage
FROM alpine:3.18
WORKDIR /app
COPY --from=builder /app/main .
COPY app.env .
EXPOSE 8080
CMD ["/app/main"]