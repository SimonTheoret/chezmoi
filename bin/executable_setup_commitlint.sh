#!/usr/bin/env sh

set -e

# npm install --save-dev @commitlint/{cli,config-conventional}
#
# echo "export default { extends: ['@commitlint/config-conventional'] };" >commitlint.config.mjs
#
# npm install --save-dev husky
#
# npx husky init
#
# # Add commit message linting to commit-msg hook and auto-changelog
# echo "npx --no -- commitlint --edit \$1" >.husky/commit-msg
#
# # Windows users should use ` to escape dollar signs
# # echo "npx --no commitlint --edit `$1" > .husky/commit-msg
#
# npm install ---save-dev conventional-changelog
# npx conventional-changelog -p angular -r 0

mkdir -p .github/workflows/




echo "
name: CI

on: [push, pull_request]

permissions:
  contents: read

jobs:
  commitlint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
      - name: Setup node
        uses: actions/setup-node@v4
        with:
          node-version: lts/*
          cache: npm
      - name: Install commitlint
        run: npm install -D @commitlint/cli @commitlint/config-conventional
      - name: Print versions
        run: |
          git --version
          node --version
          npm --version
          npx commitlint --version

      - name: Validate current commit (last commit) with commitlint
        if: github.event_name == 'push'
        run: npx commitlint --last --verbose

      - name: Validate PR commits with commitlint
        if: github.event_name == 'pull_request'
        run: npx commitlint --from \${{ github.event.pull_request.base.sha }} --to \${{ github.event.pull_request.head.sha }} --verbose
" >> .github/workflows/commitlint.yml
