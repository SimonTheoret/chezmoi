#!/usr/bin/env bash

# This very small scripts converts a list of org files to markdown files
fd --glob "*.md" -x pandoc -s -f markdown -t org -o {.}.org {}
