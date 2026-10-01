#!/bin/bash
BASE_DIR="$HOME/zach/dotfiles"

# Commit and push the changes to GitHub
git -C "$BASE_DIR" add .
git -C "$BASE_DIR" commit -m "Backup dotfiles $(date)"
git -C "$BASE_DIR" push origin main