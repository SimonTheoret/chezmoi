#!/usr/bin/env sh

git config feature.manyFiles true

git update-index --index-version 4

git config core.commitgraph true

if [ "$(uname -s)" = "Linux" ]; then
  echo "Using rs-git-fsmonitor"
  git config core.fsmonitor rs-git-fsmonitor
else
  echo "This is not Linux."
  git config core.fsmonitor true
  git fsmonitor--daemon status
fi

git gc

git config fetch.writeCommitGraph true

git commit-graph write --reachable
