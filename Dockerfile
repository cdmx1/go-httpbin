# syntax = docker/dockerfile:1.3
FROM golang:1.22 AS build

WORKDIR /go/src/github.com/cdmx1/go-httpbin

COPY . .

RUN --mount=type=cache,id=gobuild,target=/root/.cache/go-build \
    make build buildtests

FROM gcr.io/distroless/base

COPY --from=build /go/src/github.com/cdmx1/go-httpbin/dist/go-httpbin* /bin/

EXPOSE 8080
CMD ["/bin/go-httpbin"]
