#!/bin/bash
MESSAGE="Auto-commit: $(date) $(hostname)"
REPO_PATH="/Users/ssurineni/salesforce/my_notes"
git -C "$REPO_PATH" add -A
git -C "$REPO_PATH" commit -m "$MESSAGE"
git -C "$REPO_PATH" pull
git -C "$REPO_PATH" push
