#!/usr/bin/env sh

set -e

npm install --save-dev @commitlint/{cli,config-conventional}

echo "export default { extends: ['@commitlint/config-conventional'] };" >commitlint.config.mjs

npm install --save-dev husky

npx husky init

# Add commit message linting to commit-msg hook and auto-changelog
echo "npx --no -- commitlint --edit \$1" >.husky/commit-msg

# Windows users should use ` to escape dollar signs
# echo "npx --no commitlint --edit `$1" > .husky/commit-msg

npm install ---save-dev conventional-changelog
npx conventional-changelog -p angular -r 0

