#!/usr/bin/env bash

#ignore merges
isMerge=$(git rev-parse -q --verify MERGE_HEAD)
if [ -n "$isMerge" ]; then
  exit
fi

# fix with linter
dart fix --apply

# Regexp for grep to only choose some file extensions for formatting
exts="\.\(dart\)$"
echo "Pre-commit: formatting changed files"
# Format staged files
for file in $(git diff --cached --name-only --diff-filter=ACMR | grep $exts); do
    echo "Formatting $file"
    dart format --line-length=120 "$file"
    git add "$file"
done