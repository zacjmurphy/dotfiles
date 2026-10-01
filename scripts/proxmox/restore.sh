#!/usr/bin/env bash

# Load the JSON file
BASE_DIR="$HOME/dotfiles"
CONFIG_FILE="$BASE_DIR/config/proxmox/dotfiles.json"
FILES_DIR="$BASE_DIR/backup"

# Check if the repository exists
if [[ ! -d "$BASE_DIR" ]]; then
    echo "Dotfiles repository not found! Please clone your repository first."
    exit 1
fi

# Pull the latest changes from GitHub
git -C "$BASE_DIR" pull origin main

# Read the JSON and restore each file or folder
jq -c '.dotfiles[]' "$CONFIG_FILE" | while IFS= read -r item; do
    source="$FILES_DIR/$(echo "$ITEM" | jq -r '.destination')"
    destination=$(echo "$item" | jq -r '.source')
    type=$(echo "$item" | jq -r '.type')

    # Check if the source exists in the repository
    if [[ ! -e "$source" ]]; then
        echo "Source $source not found in repository. Skipping."
        continue
    fi

    # Handle based on type (file or dir)
    if [[ "$type" == "dir" ]]; then
        # If it's a directory, copy all files back
        rsync -av "$source/" "$destination/"
        echo "Restored directory $source to $destination"
    elif [[ "$type" == "file" ]]; then
        # If it's a file, just copy it directory
        cp "$source" "$destination"
        echo "Restored file $source to $destination"
    fi
done