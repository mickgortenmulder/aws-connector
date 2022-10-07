#!/usr/bin/env bash
shrt_message=`echo $message | cut -c1-5`

echo "Checking for valid commit message containing keys in order to determine the update type."

if [[ "$shrt_message" == *"fix:"* ]]; then
  echo "This change is considered a patch package update based on the commit message: $message"

elif [[ "$shrt_message" == *"feat:"* ]]; then
  echo "This change is considered a minor package update based on the commit message: $message"

elif [[ "$message" == *"BREAKING CHANGE:"* ]]; then
  echo "This change is considered a major package update based on the commit message: $message"

elif [[ "$shrt_message" == *"docs:"* ]]; then
  echo "This change is considered a documentation update based on the commit message: $message"

else
  echo "No matches based on the commit message, so exiting."
  exit 1
fi
