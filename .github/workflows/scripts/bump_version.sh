#!/usr/bin/env bash

old_version=`grep version pyproject.toml | awk '{print $3}'`
# commit_message=`git log -1 --format=%B`

echo $message
echo $old_version
# echo $commit_message
echo $new_version
echo $env
echo $repository
echo $repository_owner
echo $ref_name
echo $event
echo $pr_title

git config --global user.email "mickgortenmulder@gmail.com"
git config --global user.name "Mick Gortenmulder"
git status

if [[ "$commit_message" == *"fix"* ]]; then
  echo "Patch."
  bump2version --current-version $old_version patch pyproject.toml
  new_version=`grep version pyproject.toml | awk '{print $3}'`
  echo $new_version
  git status
  git add pyproject.toml
  git commit -m "(fix) bump version to $new_version"
  git push origin $ref_name

elif [[ "$commit_message" == *"feat"* ]]; then
  echo "Minor."
  bump2version --current-version $old_version minor pyproject.toml
  new_version=`grep version pyproject.toml | awk '{print $3}'`
  echo $new_version
  git status
  git add pyproject.toml
  git commit -m "(feat) bump version to $new_version"
  git push origin $ref_name

elif [[ "$commit_message" == *"BREAKING CHANGE"* ]]; then
  echo "Major."
  bump2version --current-version $old_version major pyproject.toml
  new_version=`grep version pyproject.toml | awk '{print $3}'`
  echo $new_version
  git status
  git add pyproject.toml
  git commit -m "bump version to $new_version"
  git push origin $ref_name

fi
