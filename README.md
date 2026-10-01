# Dotfiles
My personal dotfiles.

### Backup Script

**How It Works:**

-   Reads the `dotfiles.json` file using `jq` to extract `source` and `destination`.

-   Copies files and directories using `rsync` (for directories) and `cp` (for individual files).

-   Pushes the changes to GitHub after backing up the files.

### Restore Script

**How It Works:**

-   Pulls the latest changes from GitHub.

-   Uses `rsync` to restore directories and `cp` to restore individual files to the correct locations.

**Restore Your Dotfiles:**

If you need to restore your dotfiles to a fresh machine or after changes, run the `restore.sh` script: