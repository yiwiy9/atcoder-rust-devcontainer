#!/bin/bash

# This script serves as a workaround for the issue:
# https://github.com/qryxip/cargo-compete/pull/198
# It creates the necessary .gitkeep files within the in/out directories
# of the cargo compete testcases.

# Check if the argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path_to_project_directory>"
    exit 1
fi

project_directory=$1
testcases_directory="$project_directory/testcases"

# Check if the testcases directory exists
if [ ! -d "$testcases_directory" ]; then
    echo "Error: $testcases_directory does not exist."
    exit 1
fi

for file in "$testcases_directory"/*.yml; do
    # Get the filename without the extension
    filename=$(basename -- "$file" .yml)

    # Create .gitkeep file in the in directory if it doesn't exist
    [[ ! -d "$testcases_directory/$filename/in" ]] && mkdir -p "$testcases_directory/$filename/in"
    [[ ! -f "$testcases_directory/$filename/in/.gitkeep" ]] && touch "$testcases_directory/$filename/in/.gitkeep"

    # Create .gitkeep file in the out directory if it doesn't exist
    [[ ! -d "$testcases_directory/$filename/out" ]] && mkdir -p "$testcases_directory/$filename/out"
    [[ ! -f "$testcases_directory/$filename/out/.gitkeep" ]] && touch "$testcases_directory/$filename/out/.gitkeep"
done
