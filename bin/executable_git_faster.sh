#!/usr/bin/env sh

git config feature.manyFiles true

git update-index --index-version 4

git config core.fsmonitor true

git fsmonitor--daemon status

git config core.commitgraph true

git config fetch.writeCommitGraph true

git commit-graph write --reachable
