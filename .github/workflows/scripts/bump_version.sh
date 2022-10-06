#!/usr/bin/env bash

new_version=`grep version pyproject.toml | awk '{print $3}'`
commit_message=`git log HEAD^..HEAD --oneline --decorate`
echo $commit_message
echo $new_version
echo $env
echo $repository
echo $repository_owner
echo $ref_name
echo $event
echo $pr_title
