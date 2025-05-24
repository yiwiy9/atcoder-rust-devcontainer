#!/bin/bash

# Stop on any error
set -e

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
new_entry="        \"$cargo_toml_path\""

# --- Step 1: Locate where to insert the new entry in settings.json ---
# Read the file into an array
mapfile -t lines < "$settings_json_path"
insert_line_index=-1
found_array_start=0

# Search for the rust-analyzer.linkedProjects array and find the closing bracket ]
for i in "${!lines[@]}"; do
  line="${lines[$i]}"

  # First, find the line that contains the key
  if [[ "$line" =~ \"rust-analyzer\.linkedProjects\" ]]; then
    found_array_start=1
    continue
  fi

  # Then, look for the closing bracket ] after we've found the array key
  if [[ "$found_array_start" -eq 1 && "${line}" =~ ^[[:space:]]*\] ]]; then
    insert_line_index=$i
    break
  fi
done

# Exit if the insertion point was not found
if [ "$insert_line_index" -eq -1 ]; then
  echo "Error: Cannot find rust-analyzer.linkedProjects array in settings.json"
  exit 1
fi

# --- Step 2: Generate the contest directory using cargo-compete ---
# Only continue if cargo compete new succeeds
cargo compete new "$contest" || exit 1

# --- Step 3: Add the new linked project path to settings.json ---
# Write to a temporary file, inserting the new line before the closing bracket
tmpfile=$(mktemp)
for i in "${!lines[@]}"; do
  if [ "$i" -eq "$insert_line_index" ]; then
    echo "$new_entry," >> "$tmpfile"
  fi
  echo "${lines[$i]}" >> "$tmpfile"
done

# Overwrite the original settings.json with the modified version
mv "$tmpfile" "$settings_json_path"

# Print success message
echo "✅ Successfully added: $cargo_toml_path to settings.json"

# --- Step 4: Create a .gitkeep file inside the testcases directory ---
# Call create_gitkeep_in_testcases.sh
create_gitkeep_in_testcases.sh $contest_directory/$contest
