#!/bin/bash

# Script requires exactly one argument
if [ "$#" -ne 1 ]; then
  echo "Error: Exactly one argument required."
  echo "Usage: cargo_compete_new.sh <contest>"
  exit 1
fi

# Change the working directory to the workspace folder
cd $WORKSPACE_FOLDER

# Set variables
contest=$1
settings_json_path="$WORKSPACE_FOLDER/.vscode/settings.json"
contest_directory="./src/contest"
cargo_toml_path="$contest_directory/$contest/Cargo.toml"

# Function to print jq error
print_jq_error() {
  echo "Error: Invalid or unexpected data in settings.json" >&2
  jq "$1" $settings_json_path
  exit 1
}

# Test if the settings.json is a valid JSON
jq empty $settings_json_path >/dev/null 2>&1 || print_jq_error empty

# Get the current contents of rust-analyzer.linkedProjects
current_linked_projects=$(jq '.["rust-analyzer.linkedProjects"]' $settings_json_path) || print_jq_error '.["rust-analyzer.linkedProjects"]'

# Execute 'cargo compete new'
cargo compete new $contest || exit 1

# Add the new path
updated_linked_projects=$(echo $current_linked_projects | jq ". + [\"$cargo_toml_path\"]")

# Update settings.json
jq ". * {\"rust-analyzer.linkedProjects\": $updated_linked_projects}" $settings_json_path > temp_settings.json && mv temp_settings.json $settings_json_path || print_jq_error ". * {\"rust-analyzer.linkedProjects\": $updated_linked_projects}"

# Call create_gitkeep_in_testcases.sh
create_gitkeep_in_testcases.sh $contest_directory/$contest
