#!/bin/bash

export GITHUB_SHA="69a3b64e5b36db68b54ca7291d8acfde261dda76"
# Enter your url.....don't commit this
export DISCORD_URL=""
export GITHUB_REPOSITORY="DiscordHooks/github-actions-discord-webhook"
export GITHUB_REF="refs/heads/4/merge" # refs/heads/feature/new-stuff
export HOOK_OS_NAME="Windows"
export WORKFLOW_NAME="Main Pipeline"
export GITHUB_EVENT_NAME="pull_request" # Could also be push, ext.
./send.sh Success $DISCORD_URL