FROM golang:1.12

LABEL "com.github.actions.name"="staticcheck"
LABEL "com.github.actions.description"="Run staticcheck"
LABEL "com.github.actions.icon"="terminal"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="https://github.com/grandcolline/golang-github-actions"
LABEL "homepage"="https://github.com/grandcolline/golang-github-actions"
LABEL "maintainer"="grandcolline <grandcolline@gmail.com>"

RUN apt-get update && \
	apt-get -y install jq && \
	go get -u honnef.co/go/tools/cmd/staticcheck

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
