FROM golang:1.23rc1-alpine3.20 AS builder

ENV CGO_ENABLED 0

ENV GOOS linux

ENV GOARCH=amd64

WORKDIR /app

ADD go.mod .

ADD go.sum .

RUN go mod download

COPY . .

RUN go build -o /my_doc



FROM alpine

WORKDIR /my_doc

COPY --from=builder /my_doc .

COPY tracker.db .

CMD ["./my_doc"]