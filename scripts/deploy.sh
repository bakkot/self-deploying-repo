#!/bin/bash

set -euxo pipefail


### Customize these variables to suit your project

declare -r GH_USER_EMAIL="bot@example.com"
declare -r GH_USER_NAME="Self-deploy bot"
declare -r COMMIT_MESSAGE="Update gh-pages"


### Probably leave the steps after this alone

declare -r PRIVATE_KEY_FILE_NAME='github_deploy_key'

cd "$(dirname "$BASH_SOURCE")"/../out

git config --global user.email "${GH_USER_EMAIL}"
git config --global user.name "${GH_USER_NAME}"
git config --global init.defaultBranch gh-pages
git init
git add -A
git commit --message "${COMMIT_MESSAGE}"
git push --force "https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git" gh-pages
