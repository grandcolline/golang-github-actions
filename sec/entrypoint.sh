#!/bin/sh
set -e
APP_DIR="/go/src/github.com/${GITHUB_REPOSITORY}/"
mkdir -p ${APP_DIR} && cp -r ./ ${APP_DIR}
cd "${APP_DIR}/${GO_ACTION_WORKING_DIR:-.}"

export GO111MODULE=on
if [ ! -e go.mod ]; then
	go mod init
fi
go mod download

set +e
gosec -out result.txt ${FLAGS} ./...
SUCCESS=$?
set -e

if [ ${SUCCESS} -eq 0 ]; then
    exit 0
fi

if [ "${GO_ACTION_COMMENT}" = "1" ] || [ "${GO_ACTION_COMMENT}" = "false" ]; then
    exit ${SUCCESS}
fi

COMMENT="## gosec Failed

\`\`\`
$(tail -n 6 result.txt)
\`\`\`

<details><summary>Show Detail</summary>

\`\`\`
$(cat result.txt)
\`\`\`

</details>
"

PAYLOAD=$(echo '{}' | jq --arg body "${COMMENT}" '.body = $body')
COMMENTS_URL=$(cat /github/workflow/event.json | jq -r .pull_request.comments_url)
curl -s -S -H "Authorization: token ${GITHUB_TOKEN}" --header "Content-Type: application/json" --data "${PAYLOAD}" "${COMMENTS_URL}" > /dev/null

exit ${SUCCESS}
