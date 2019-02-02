#!/bin/sh
set -e
cd "${GO_ACTION_WORKING_DIR:-.}"

set +e
UNFMT_FILES=$(sh -c "gofmt -l . $*" 2>&1)
test -z "${UNFMT_FILES}"
SUCCESS=$?
echo "${UNFMT_FILES}"
set -e

if [ ${SUCCESS} -eq 0 ]; then
    exit 0
fi

if [ "${GO_ACTION_COMMENT}" = "1" ] || [ "${GO_ACTION_COMMENT}" = "false" ]; then
    exit ${SUCCESS}
fi

FMT_OUTPUT=""
for file in ${UNFMT_FILES}; do
FILE_DIFF=$(gofmt -d -e "${file}" | sed -n '/@@.*/,//{/@@.*/d;p}')
FMT_OUTPUT="${FMT_OUTPUT}
<details><summary><code>${file}</code></summary>

\`\`\`diff
${FILE_DIFF}
\`\`\`
</details>

"
done

COMMENT="## gofmt Failed
${FMT_OUTPUT}
"
PAYLOAD=$(echo '{}' | jq --arg body "${COMMENT}" '.body = $body')
COMMENTS_URL=$(cat /github/workflow/event.json | jq -r .pull_request.comments_url)
curl -s -S -H "Authorization: token ${GITHUB_TOKEN}" --header "Content-Type: application/json" --data "${PAYLOAD}" "${COMMENTS_URL}" > /dev/null

exit ${SUCCESS}
