#!/usr/bin/env bash -xe

latest=$(git tag -l --sort=v:refname | grep "^v[0-9]\+\.[0-9]\+\.[0-9]\+" | sort -r | head -n 1)
current_patch=$(echo $latest | grep -o "[0-9]\+$")
patch=$(($current_patch + 1))
major_minor=$(echo $latest | grep -o "^v[0-9]\+\.[0-9]\+\.")
new=$major_minor$patch

git tag $new
