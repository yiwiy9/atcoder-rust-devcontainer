#!/bin/bash

settings_json=".vscode/settings.json"
example_json=".vscode/settings.exapmle.json"

if [ ! -f "$settings_json" ]; then
    cp "$example_json" "$settings_json"
fi
