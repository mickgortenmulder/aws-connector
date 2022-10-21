#!/usr/bin/env bash
git config --global user.email "mickgortenmulder@gmail.com"
git config --global user.name "Mick Gortenmulder"
git add . ; git commit -m 'Commit changes'

new_version=`grep version pyproject.toml | awk '{print $3}'`
echo "New version: $new_version"
auto-changelog --latest-version $new_version --unreleased --github --description "This is an automatically generate changelog for the aws-connector Python package"
git add CHANGELOG.md
git commit -m "Auto generate changelog from latest version: $new_version"
git push origin $ref_name
