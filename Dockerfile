FROM golang:1.17-buster

ENV GO111MODULE=on

RUN apt-get update && \
	apt-get -y install jq

RUN go install github.com/kisielk/errcheck@v1.6.0
RUN go install golang.org/x/tools/cmd/goimports@latest
RUN go install golang.org/x/lint/golint@latest
RUN go install github.com/securego/gosec/cmd/gosec@latest
RUN go install golang.org/x/tools/go/analysis/passes/shadow/cmd/shadow@latest
RUN go install honnef.co/go/tools/cmd/staticcheck@latest

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
