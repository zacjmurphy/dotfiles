#!/usr/bin/env bash

# Load the JSON file
BASE_DIR="$HOME/dotfiles"
CONFIG_FILE="$BASE_DIR/config/proxmox/dotfiles.json"
FILES_DIR="$BASE_DIR/backup"

echo "Backing up files to $FILES_DIR"
echo "Using config file $CONFIG_FILE"
echo "Using base directory $BASE_DIR"

# Check if the repository exists
if [[ ! -d "$BASE_DIR" ]]; then
    echo "Dotfiles repository not found! Please clone your repository first."
    exit 1
fi

# Read the JSON and backup each file or folder
jq -c '.dotfiles[]' "$CONFIG_FILE" | while IFS= read -r item; do
    echo "Processing item: $item"

    # Extract the Values from the JSON Object
    source=$(echo "$item" | jq -r '.source')
    destination=$(echo "$item" | jq -r '.destination')
    type=$(echo "$item" | jq -r '.type')

    # Check if the source exists
    if [[ ! -e "$source" ]]; then
        echo "⚠️ Source $source not found. Skipping"
        continue
    fi

    # Handle based on type (file or dir)
    if [[ "$type" == "dir" ]]; then
        # If it's a directory, copy all files inside it
        dest_dir="$FILES_DIR/$destination"
        mkdir -p "$dest_dir"
        rsync -av --exclude='.git/' "$source/" "$dest_dir/"
        echo "✅ Backed up directory $source to $FILES_DIR/$destination"
    elif [[ "$type" == "file" ]]; then
        # If it's a file, ensure the directory for the destination exists, then copy the file
        dest_dir=$(dirname "$FILES_DIR/$destination")
        mkdir -p "$dest_dir"
        cp "$source" "$FILES_DIR/$destination"
        echo "✅ Backed up file $source to $FILES_DIR/$destination"
    fi
done