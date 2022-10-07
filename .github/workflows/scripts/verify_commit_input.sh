#!/usr/bin/env bash
shrt_message=`echo $message | cut -c1-5`
echo "Full message: $message"
echo "Short message: $shrt_message"
echo "Checking for valid commit message containing keys in order to determine the update type."

if [[ "$shrt_message" == *"fix:"* ]]; then
  echo "Matched on 'fix:' as a patch update"

elif [[ "$shrt_message" == *"feat:"* ]]; then
  echo "Matched on 'feat:' as a minor update"

elif [[ "$message" == *"BREAKING CHANGE:"* ]]; then
  echo "Matched on 'BREAKING CHANGE:' as a major update"

elif [[ "$shrt_message" == *"docs:"* ]]; then
  echo "Matched on 'docs:' as a documentation update"

else
  echo "No matches based on the commit message, exiting."
  exit 1
fi
