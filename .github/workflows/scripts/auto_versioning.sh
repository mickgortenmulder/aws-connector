#!/usr/bin/env bash
old_version=`grep version pyproject.toml | awk '{print $3}'`
echo "Old package version: $old_version"
shrt_message=`echo $message | cut -c1-4`
echo "Commit message: $shrt_message"

git config --global user.email "mickgortenmulder@gmail.com"
git config --global user.name "Mick Gortenmulder"
git add . ; git commit -m 'Commit changes'

if [[ "$shrt_message" == *"fix"* ]]; then
  echo "This change is considered a patch package update based on the commit message: $message"
  bump2version --current-version $old_version patch pyproject.toml

elif [[ "$shrt_message" == *"feat"* ]]; then
  echo "This change is considered a minor package update based on the commit message: $message"
  bump2version --current-version $old_version minor pyproject.toml

elif [[ "$message" == *"BREAKING CHANGE:"* ]]; then
  echo "This change is considered a major package update based on the commit message: $message"
  bump2version --current-version $old_version major pyproject.toml

elif [[ "$shrt_message" == *"docs"* ]]; then
  echo "This change is considered a documentation update based on the commit message: $message"
  bump2version --current-version $old_version patch pyproject.toml

else
  echo "Commit message error, exiting."
  exit 1
fi

if [ "$old_version" != "$new_version" ]; then
  new_version=`grep version pyproject.toml | awk '{print $3}'`
  echo $new_version
  git add pyproject.toml

  echo "Auto generating changelog from $new_version into CHANGELOG.md."
  auto-changelog --latest-version $new_version --unreleased --github --description "This is an automatically generate changelog for the aws-connector Python package"
  git add CHANGELOG.md

  git commit -m "Automatic version update to $new_version"
  git push origin $ref_name

  echo "Starting the tagging"
  git tag $new_version -a
  git push origin --tags
  echo "Tagging done"
else
  echo "Nothing to update, exiting."
  exit 1
fi
