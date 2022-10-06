#!/usr/bin/env bash
old_version=`grep version pyproject.toml | awk '{print $3}'`
echo "Commit message: $message"
echo "Old package version: $old_version"
echo "New package version: $new_version"
echo "Env: $env"

git config --global user.email "mickgortenmulder@gmail.com"
git config --global user.name "Mick Gortenmulder"
git add . ; git commit -m 'Commit changes'

if [[ "$message" == *"fix"* ]]; then
  echo "Patch update."
  bump2version --current-version $old_version patch pyproject.toml

elif [[ "$message" == *"feat"* ]]; then
  echo "Minor update."
  bump2version --current-version $old_version minor pyproject.toml

elif [[ "$message" == *"BREAKING CHANGE"* ]]; then
  echo "Major update."
  bump2version --current-version $old_version major pyproject.toml

else
  echo "No matches"
fi

if [ "$old_version" != "$new_version" ]; then
  new_version=`grep version pyproject.toml | awk '{print $3}'`
  echo $new_version
  git add pyproject.toml
  git commit -m "Automatic version update to $new_version"
  git push origin $ref_name
else
  echo "Nothing to update"
fi
