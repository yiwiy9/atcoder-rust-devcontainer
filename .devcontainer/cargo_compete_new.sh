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
CONTEST=$1
SETTINGS_JSON_PATH="${WORKSPACE_FOLDER}/.vscode/settings.json"
CARGO_TOML_PATH="./src/contest/${CONTEST}/Cargo.toml"

# Function to print jq error
print_jq_error() {
  echo "Error: Invalid or unexpected data in settings.json" >&2
  jq "$1" $SETTINGS_JSON_PATH
  exit 1
}

# Test if the settings.json is a valid JSON
jq empty $SETTINGS_JSON_PATH >/dev/null 2>&1 || print_jq_error empty

# Get the current contents of rust-analyzer.linkedProjects
CURRENT_LINKED_PROJECTS=$(jq '.["rust-analyzer.linkedProjects"]' $SETTINGS_JSON_PATH) || print_jq_error '.["rust-analyzer.linkedProjects"]'

# Execute 'cargo compete new'
cargo compete new $CONTEST || exit 1

# Add the new path
UPDATED_LINKED_PROJECTS=$(echo $CURRENT_LINKED_PROJECTS | jq ". + [\"$CARGO_TOML_PATH\"]")

# Update settings.json
jq ". * {\"rust-analyzer.linkedProjects\": $UPDATED_LINKED_PROJECTS}" $SETTINGS_JSON_PATH > temp_settings.json && mv temp_settings.json $SETTINGS_JSON_PATH || print_jq_error ". * {\"rust-analyzer.linkedProjects\": $UPDATED_LINKED_PROJECTS}"
