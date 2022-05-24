FROM golang:1.18

ENV GO111MODULE=on

RUN apt-get update && \
	apt-get -y install jq && \
	go install github.com/kisielk/errcheck@latest && \
	go install golang.org/x/tools/cmd/goimports@latest && \
	go install golang.org/x/lint/golint@latest && \
	go install golang.org/x/tools/go/analysis/passes/shadow/cmd/shadow@latest && \
	go install honnef.co/go/tools/cmd/staticcheck@latest

# Manually install a patched version of gosec
RUN git clone https://github.com/convictional/gosec && cd gosec && go install . && cd ..

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
