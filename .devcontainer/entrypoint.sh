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

# Define the path for lib.rs and check its existence
lib_rs_path="$WORKSPACE_FOLDER/src/lib/src/lib.rs"
if [ ! -f "$lib_rs_path" ]; then
    touch "$lib_rs_path"
fi

# Generate Rust code snippets
cargo_snippet.sh

# Sign in automatically for Atcoder website
cargo compete login atcoder <<EOF
$ATCODER_USERNAME
$ATCODER_PASSWORD
EOF

# Sign in for Yukicoder if the API key is set
if [ -n "$YUKICODER_API_KEY" ]; then
    cargo compete login yukicoder
fi
