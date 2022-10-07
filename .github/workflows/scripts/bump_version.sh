#!/usr/bin/env bash
old_version=`grep version pyproject.toml | awk '{print $3}'`
echo "Old package version: $old_version"
shrt_message=`echo $message | cut -c1-4`

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
  echo "No matches [Major, Minor, Patch] based on the commit message, so no version is bumped."
  echo "Commit messages need to contain 'fix:', 'feat:', 'docs:' or 'BREAKING CHANGE:'."
  exit 1
fi

if [ "$old_version" != "$new_version" ]; then
  new_version=`grep version pyproject.toml | awk '{print $3}'`
  echo $new_version
  git add pyproject.toml
  git commit -m "Automatic version update to $new_version"
  git push origin $ref_name
else
  echo "Nothing to update"
  exit 1
fi
