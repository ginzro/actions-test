#!/usr/bin/env bash
set -xe

latest=$(git tag -l --sort=v:refname | grep "^v[0-9]\+\.[0-9]\+\.[0-9]\+" | sort -r -V | head -n 1)
current_patch=$(echo $latest | grep -o "[0-9]\+$")
patch=$(($current_patch + 1))
major_minor=$(echo $latest | grep -o "^v[0-9]\+\.[0-9]\+\.")
new=$major_minor$patch

git tag $new
curl -v -d @- --request POST \
        --url https://api.github.com/repos/${GITHUB_REPOSITORY}/git/tags \
        --header "Authorization: token $GITHUB_TOKEN" \
        --header 'Content-Type: application/json' \
        --header "Accept: application/vnd.github.v3+json" <<EOF
{
  "tag": "${new}",
  "message": "This tag created by Github Actions",
  "object": "${GITHUB_SHA}",
  "type": "commit"
}
EOF

