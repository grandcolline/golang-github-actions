#!/bin/sh
set -e
APP_DIR="/go/src/github.com/${GITHUB_REPOSITORY}/"
mkdir -p ${APP_DIR} && cp -r ./ ${APP_DIR}
cd "${APP_DIR}/${GO_ACTION_WORKING_DIR:-.}"

export GO111MODULE=on
go mod download

set +e
OUTPUT=$(sh -c "gosec ${FLAGS} ./... $*" 2>&1)
SUCCESS=$?
echo "${OUTPUT}"
set -e

if [ ${SUCCESS} -eq 0 ]; then
    exit 0
fi

if [ "${GO_ACTION_COMMENT}" = "1" ] || [ "${GO_ACTION_COMMENT}" = "false" ]; then
    exit ${SUCCESS}
fi

COMMENT="## gosec Failed

\`\`\`
${OUTPUT}
\`\`\`

"

PAYLOAD=$(echo '{}' | jq --arg body "${COMMENT}" '.body = $body')
COMMENTS_URL=$(cat /github/workflow/event.json | jq -r .pull_request.comments_url)
curl -s -S -H "Authorization: token ${GITHUB_TOKEN}" --header "Content-Type: application/json" --data "${PAYLOAD}" "${COMMENTS_URL}" > /dev/null

exit ${SUCCESS}
