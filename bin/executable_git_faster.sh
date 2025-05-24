#!/usr/bin/env sh

git config feature.manyFiles true

git update-index --index-version 4

git config core.fsmonitor true

git fsmonitor--daemon status

git config core.commitgraph true


if [ "$(uname -s)" = "Linux" ]; then
  echo "Using rs-git-fsmonitor"
  git config core.fsmonitor rs-git-fsmonitor
  git fsmonitor--daemon status
else
  echo "This is not Linux."
  git config core.fsmonitor true
  git fsmonitor--daemon status
fi

git config fetch.writeCommitGraph true

git commit-graph write --reachable
