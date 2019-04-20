FROM golang:1.12

LABEL "com.github.actions.name"="go fmt"
LABEL "com.github.actions.description"="Run gofmt"
LABEL "com.github.actions.icon"="terminal"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="https://github.com/grandcolline/golang-github-actions"
LABEL "homepage"="https://github.com/grandcolline/golang-github-actions"
LABEL "maintainer"="grandcolline <grandcolline@gmail.com>"

RUN apt-get update && \
	apt-get -y install jq

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
