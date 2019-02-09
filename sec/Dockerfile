FROM golang:1.11

LABEL "com.github.actions.name"="gosec"
LABEL "com.github.actions.description"="Run gosec"
LABEL "com.github.actions.icon"="terminal"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="https://github.com/grandcolline/golang-github-actions"
LABEL "homepage"="https://github.com/grandcolline/golang-github-actions"
LABEL "maintainer"="grandcolline <grandcolline@gmail.com>"

RUN apt-get update && \
	apt-get -y install jq && \
	go get -u github.com/securego/gosec/cmd/gosec

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
