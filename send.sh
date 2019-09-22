#!/bin/bash
# This original source of this code: https://github.com/DiscordHooks/travis-ci-discord-webhook
# The same functionality from TravisCI is needed for Github Actions
#
# For info on the GITHUB prefixed variables, visit:
# https://help.github.com/en/articles/virtual-environments-for-github-actions#environment-variables
if [ -z "$2" ]; then
  echo -e "WARNING!!\nYou need to pass the WEBHOOK_URL environment variable as the second argument to this script.\nFor details & guide, visit: https://github.com/DiscordHooks/travis-ci-discord-webhook" && exit
fi

echo -e "[Webhook]: Sending webhook to Discord...\\n";

AVATAR="https://avatars0.githubusercontent.com/u/44036562?s=200"

case $1 in
  "Success" )
    EMBED_COLOR=3066993
    STATUS_MESSAGE="Passed"
    ;;

  "Failure" )
    EMBED_COLOR=15158332
    STATUS_MESSAGE="Failed"
    ;;

  * )
    STATUS_MESSAGE="Status Unknown"
    EMBED_COLOR=0
    ;;
esac

AUTHOR_NAME="$(git log -1 "$GITHUB_SHA" --pretty="%aN")"
COMMITTER_NAME="$(git log -1 "$GITHUB_SHA" --pretty="%cN")"
COMMIT_SUBJECT="$(git log -1 "$GITHUB_SHA" --pretty="%s")"
COMMIT_MESSAGE="$(git log -1 "$GITHUB_SHA" --pretty="%b")" | sed -E ':a;N;$!ba;s/\r{0,1}\n/\\n/g'
COMMIT_URL="https://github.com/$GITHUB_REPOSITORY/commit/$GITHUB_SHA"

# If, for example, $GITHUB_REF = refs/heads/feature/example-branch
# Then this sed command returns: feature/example-branch
BRANCH_NAME="$(echo $GITHUB_REF | sed 's/^.*\/.*\///g')"
BRANCH_URL="https://github.com/$GITHUB_REPOSITORY/tree/$BRANCH_NAME"

if [ "$AUTHOR_NAME" == "$COMMITTER_NAME" ]; then
  CREDITS="$AUTHOR_NAME authored & committed"
else
  CREDITS="$AUTHOR_NAME authored & $COMMITTER_NAME committed"
fi

TIMESTAMP=$(date --utc +%FT%TZ)
WEBHOOK_DATA='{
  "username": "",
  "avatar_url": "'$AVATAR'",
  "embeds": [ {
    "color": '$EMBED_COLOR',
    "author": {
      "name": "Build '"$STATUS_MESSAGE"' - '"$GITHUB_REPOSITORY"'",
      "url": "'$COMMIT_URL'",
      "icon_url": "'$AVATAR'"
    },
    "title": "'"$COMMIT_SUBJECT"'",
    "url": "'"$URL"'",
    "description": "'"${COMMIT_MESSAGE//$'\n'/ }"\\n\\n"$CREDITS"'",
    "fields": [
      {
        "name": "Commit",
        "value": "'"[\`${GITHUB_SHA:0:7}\`](${COMMIT_URL})"'",
        "inline": true
      },
      {
        "name": "Branch",
        "value": "'"[\`${BRANCH_NAME}\`](${BRANCH_URL})"'",
        "inline": true
      }
    ],
    "timestamp": "'"$TIMESTAMP"'"
  } ]
}'

(curl --fail --progress-bar -A "GitHub-Actions-Webhook" -H Content-Type:application/json -H X-Author:k3rn31p4nic#8383 -d "${WEBHOOK_DATA//	/ }" "$2" \
  && echo -e "\\n[Webhook]: Successfully sent the webhook.") || echo -e "\\n[Webhook]: Unable to send webhook."
