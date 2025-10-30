#!/bin/bash
# === Git Auto Commit & Push Script ===
# Usage: ./git_update.sh "Your commit message"

# Stop on errors
set -e

# Check if inside a git repo
if [ ! -d ".git" ]; then
  echo "❌ Not a git repository. Please run this inside your project folder."
  exit 1
fi

# Stage all changes
git add .

# Commit message (use provided one or default)
if [ -z "$1" ]; then
  COMMIT_MSG="Auto update on $(date '+%Y-%m-%d %H:%M:%S')"
else
  COMMIT_MSG="$1"
fi

git commit -m "$COMMIT_MSG"

# Push to GitHub
git push origin main

echo "✅ Successfully committed and pushed!"
