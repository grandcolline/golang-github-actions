FROM golang:1.12

LABEL "com.github.actions.name"="shadow"
LABEL "com.github.actions.description"="Run go vet -vettool=/go/bin/shadow"
LABEL "com.github.actions.icon"="terminal"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="https://github.com/grandcolline/golang-github-actions"
LABEL "homepage"="https://github.com/grandcolline/golang-github-actions"
LABEL "maintainer"="grandcolline <grandcolline@gmail.com>"

RUN apt-get update && \
	apt-get -y install jq

RUN go get -u golang.org/x/tools/go/analysis/passes/shadow/cmd/shadow

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
