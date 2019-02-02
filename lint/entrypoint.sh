#!/bin/sh
set -e
cd "${GO_ACTION_WORKING_DIR:-.}"

set +e
OUTPUT=$(sh -c "golint -set_exit_status ./... $*" 2>&1)
SUCCESS=$?
echo "${OUTPUT}"
set -e

if [ ${SUCCESS} -eq 0 ]; then
    exit 0
fi

if [ "${GO_ACTION_COMMENT}" = "1" ] || [ "${GO_ACTION_COMMENT}" = "false" ]; then
    exit $SUCCESS
fi

SHORT_OUTPUT=$(echo "${OUTPUT}" | awk 'END{print}')
FMT_OUTPUT="${SHORT_OUTPUT}
<details><summary>Show Detail</summary>

\`\`\`
${OUTPUT}
\`\`\`

</details>
"

COMMENT="## golint Failed
${FMT_OUTPUT}"

PAYLOAD=$(echo '{}' | jq --arg body "${COMMENT}" '.body = $body')
COMMENTS_URL=$(cat /github/workflow/event.json | jq -r .pull_request.comments_url)
curl -s -S -H "Authorization: token ${GITHUB_TOKEN}" --header "Content-Type: application/json" --data "${PAYLOAD}" "${COMMENTS_URL}" > /dev/null

exit ${SUCCESS}
