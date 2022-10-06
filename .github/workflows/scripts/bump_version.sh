#!/usr/bin/env bash

old_version=`grep version pyproject.toml | awk '{print $3}'`
commit_message=`git log -1 --format=%B`

echo $message
echo $commit_message
echo $new_version
echo $env
echo $repository
echo $repository_owner
echo $ref_name
echo $event
echo $pr_title

git status

if [[ "$commit_message" == *"fix"* ]]; then
  bump2version --current-version $old_version patch pyproject.toml
  echo "Patch."
elif [[ "$commit_message" == *"feat"* ]]; then
  bump2version --current-version $old_version minor pyproject.toml
  echo "Minor."
elif [[ "$commit_message" == *"BREAKING CHANGE"* ]]; then
  bump2version --current-version $old_version major pyproject.toml
  echo "Major."
fi

git status
git add . ; git commit -m 'bump version'
