#!/bin/bash

# Install script for claude-code-md
# Downloads and installs agents and commands from GitHub to a project's .claude/ folder

set -e

# GitHub repository configuration
REPO_OWNER="BenjaminFont"
REPO_NAME="claude-code-md"
BRANCH="main"

INSTALL_AGENTS=true
INSTALL_COMMANDS=true

# Parse flags
while [[ $# -gt 0 ]]; do
  case $1 in
    --agents-only)
      INSTALL_COMMANDS=false
      shift
      ;;
    --commands-only)
      INSTALL_AGENTS=false
      shift
      ;;
    -h|--help)
      echo "Usage: install.sh [OPTIONS] <target-dir>"
      echo ""
      echo "Install claude-code-md agents and commands from GitHub to a project."
      echo ""
      echo "Options:"
      echo "  --agents-only    Only install agents"
      echo "  --commands-only  Only install commands"
      echo "  -h, --help       Show this help message"
      echo ""
      echo "Examples:"
      echo "  # Install everything"
      echo "  curl -fsSL https://raw.githubusercontent.com/$REPO_OWNER/$REPO_NAME/$BRANCH/install.sh | bash -s -- /path/to/project"
      echo ""
      echo "  # Only agents"
      echo "  curl -fsSL https://raw.githubusercontent.com/$REPO_OWNER/$REPO_NAME/$BRANCH/install.sh | bash -s -- --agents-only /path/to/project"
      echo ""
      echo "  # Only commands"
      echo "  curl -fsSL https://raw.githubusercontent.com/$REPO_OWNER/$REPO_NAME/$BRANCH/install.sh | bash -s -- --commands-only /path/to/project"
      exit 0
      ;;
    *)
      TARGET_DIR="$1"
      shift
      ;;
  esac
done

# Validate target directory
if [ -z "$TARGET_DIR" ]; then
  echo "Error: No target directory specified"
  echo "Usage: curl -fsSL <script-url> | bash -s -- [--agents-only|--commands-only] <target-dir>"
  exit 1
fi

# Resolve to absolute path
TARGET_DIR="$(cd "$TARGET_DIR" 2>/dev/null && pwd)" || {
  echo "Error: Target directory does not exist: $TARGET_DIR"
  exit 1
}

# Create temp directory for download
TMP_DIR=$(mktemp -d)
trap "rm -rf $TMP_DIR" EXIT

echo "Downloading from GitHub..."

# Download repository as tarball
TARBALL_URL="https://github.com/$REPO_OWNER/$REPO_NAME/archive/refs/heads/$BRANCH.tar.gz"
curl -fsSL "$TARBALL_URL" | tar -xz -C "$TMP_DIR"

# The extracted folder is named repo-branch
EXTRACT_DIR="$TMP_DIR/$REPO_NAME-$BRANCH"

if [ ! -d "$EXTRACT_DIR" ]; then
  echo "Error: Failed to download repository"
  exit 1
fi

# Create .claude directory if needed
mkdir -p "$TARGET_DIR/.claude"

# Install agents
if [ "$INSTALL_AGENTS" = true ]; then
  if [ -d "$EXTRACT_DIR/agents" ]; then
    echo "Installing agents..."
    cp -r "$EXTRACT_DIR/agents" "$TARGET_DIR/.claude/"
    for file in "$EXTRACT_DIR/agents"/*.md; do
      [ -f "$file" ] && echo "  - $(basename "$file")"
    done
    echo "Installed agents"
  else
    echo "Warning: No agents directory found in repository"
  fi
fi

# Install commands
if [ "$INSTALL_COMMANDS" = true ]; then
  if [ -d "$EXTRACT_DIR/commands" ]; then
    echo "Installing commands..."
    cp -r "$EXTRACT_DIR/commands" "$TARGET_DIR/.claude/"
    # List top-level command files
    for file in "$EXTRACT_DIR/commands"/*.md; do
      [ -f "$file" ] && echo "  - $(basename "$file")"
    done
    # List workflow files
    if [ -d "$EXTRACT_DIR/commands/workflow" ]; then
      for file in "$EXTRACT_DIR/commands/workflow"/*.md; do
        [ -f "$file" ] && echo "  - workflow/$(basename "$file")"
      done
    fi
    echo "Installed commands"
  else
    echo "Warning: No commands directory found in repository"
  fi
fi

echo ""
echo "Done! Installed to $TARGET_DIR/.claude/"
