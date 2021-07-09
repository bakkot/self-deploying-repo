#!/bin/bash

set -euxo pipefail

cd "$(dirname "$BASH_SOURCE")"/..
mkdir -p out


### Put your build process below here

cat <<EOF > out/index.html
<!doctype html>
<!doctype html>
<html lang="en">
<meta charset="utf-8">
<title>Self-deploying repo</title>
<p>The last commit in <a href="https://github.com/${GITHUB_REPOSITORY}">${GITHUB_REPOSITORY}</a> was $(git rev-parse --short HEAD).</p>
EOF
