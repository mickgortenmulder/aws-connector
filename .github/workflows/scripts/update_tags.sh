#!/usr/bin/env bash
version=`grep version pyproject.toml | awk '{print $3}'`
echo "Version that will be tagged: $version"

git config --global user.email "mickgortenmulder@gmail.com"
git config --global user.name "Mick Gortenmulder"
git add . ; git commit -m 'Commit changes'

echo "Starting the tagging"
git tag $version -a
git push origin --tags

echo "Tagging done"
