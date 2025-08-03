#!/usr/bin/env sh

rclone bisync org:org-notes ~/org --create-empty-src-dirs --compare size,modtime,checksum --slow-hash-sync-only -MvP --fix-case
