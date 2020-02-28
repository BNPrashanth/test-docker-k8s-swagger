FROM golang:alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN apk add git
RUN go mod download
ADD . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o news-service ./cmd/test-service-server/main.go

FROM alpine
WORKDIR /app
COPY --from=builder /app/ /app/
EXPOSE 8082
CMD ["./test-service"]