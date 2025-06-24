#!/usr/bin/env sh

set -e

mkdir -p .github/workflows/

echo "
name: Lint Commit Messages
on: [pull_request, push]

permissions:
  contents: read
  pull-requests: read

jobs:
  commitlint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: wagoid/commitlint-github-action@v6
" >>.github/workflows/commitlint.yml
