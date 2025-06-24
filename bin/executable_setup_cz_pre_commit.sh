#!/usr/bin/env sh

set -e

cz init

echo "
repos:
  - repo: https://github.com/commitizen-tools/commitizen
    rev: master  # Replace with latest tag
    hooks:
      - id: commitizen
      - id: commitizen-branch
        stages: [pre-push]
" >>.pre-commit-config.yaml
pre-commit autoupdate
pre-commit install --hook-type commit-msg --hook-type pre-push
