#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Error: Exactly one argument required."
  echo "Usage: cargo_compete_new.sh <contest>"
  exit 1
fi

# Change the working directory to the workspace folder
cd $WORKSPACE_FOLDER

# Execute 'cargo compete new'
if ! cargo compete new $1; then
  exit 1
fi

# Get the relative path to Cargo.toml
cargo_toml_path="./src/contest/$1/Cargo.toml"

# If settings.json file exists, add the path to rust-analyzer.linkedProjects
settings_json_path="./.vscode/settings.json"

# Get the current contents of rust-analyzer.linkedProjects
current_linked_projects=$(jq '.["rust-analyzer.linkedProjects"]' $settings_json_path)

# Add the new path
updated_linked_projects=$(echo $current_linked_projects | jq ". + [\"$cargo_toml_path\"]")

# Update settings.json
jq ". * {\"rust-analyzer.linkedProjects\": $updated_linked_projects}" $settings_json_path > temp_settings.json && mv temp_settings.json $settings_json_path
