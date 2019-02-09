FROM golang:1.11

LABEL "com.github.actions.name"="go lint"
LABEL "com.github.actions.description"="Run golint"
LABEL "com.github.actions.icon"="terminal"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="https://github.com/grandcolline/golang-github-actions"
LABEL "homepage"="https://github.com/grandcolline/golang-github-actions"
LABEL "maintainer"="grandcolline <grandcolline@gmail.com>"

RUN apt-get update && \
	apt-get -y install jq && \
	go get -u golang.org/x/lint/golint

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
