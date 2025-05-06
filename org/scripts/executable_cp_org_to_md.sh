#!/usr/bin/env bash

# This very small scripts converts a list of org files to markdown files
fd --glob "*.org" -x pandoc -s -t markdown -f org -o {.}.md {}
