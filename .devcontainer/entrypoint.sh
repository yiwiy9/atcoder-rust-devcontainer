#!/bin/bash

# Create VS Code settings file for rust-analyzer if it doesn't exist
settings_json=".vscode/settings.json"
example_json=".vscode/settings.exapmle.json"
if [ ! -f "$settings_json" ]; then
    cp "$example_json" "$settings_json"
fi

# Sign in automatically for Atcoder website
cargo compete login atcoder <<EOF
$ATCODER_USERNAME
$ATCODER_PASSWORD
EOF
