#!/bin/bash

# Define paths for VS Code settings
vscode_directory="$WORKSPACE_FOLDER/.vscode"
settings_json="$vscode_directory/settings.json"
example_json="$WORKSPACE_FOLDER/.devcontainer/settings.example.json"

# Ensure the .vscode directory exists
mkdir -p "$vscode_directory"

# If settings.json doesn't exist, copy from the example settings
if [ ! -f "$settings_json" ]; then
    cp "$example_json" "$settings_json"
fi

# Generate Rust code snippets
cargo_snippet.sh

# Sign in automatically for Atcoder website
cargo compete login atcoder <<EOF
$ATCODER_USERNAME
$ATCODER_PASSWORD
EOF
