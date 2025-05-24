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
echo ""

### Sign in automatically for Atcoder website
# Setup cargo-compete cookies
CARGO_COMPETE_DIR="/root/.local/share/cargo-compete"
mkdir -p "$CARGO_COMPETE_DIR"

# Write REVEL_SESSION cookie (always overwrite)
if [ -n "$ATCODER_REVEL_SESSION" ]; then
    cat > "$CARGO_COMPETE_DIR/cookies.jsonl" <<EOF
{"raw_cookie":"REVEL_SESSION=$ATCODER_REVEL_SESSION;","path":["/",true],"domain":{"HostOnly":"atcoder.jp"},"expires":{"AtUtc":"2099-12-31T23:59:59Z"}}
EOF
    echo "✔ REVEL_SESSION written to $CARGO_COMPETE_DIR/cookies.jsonl"
else
    echo "⚠ ATCODER_REVEL_SESSION is not set. Proceeding, but login may fail."
fi
echo ""

# Attempt login and capture output
echo "🔐 Attempting cargo compete login atcoder..."
# Try login with timeout to avoid blocking if it prompts for input
login_output=$(timeout 5 cargo compete login atcoder 2>&1)

# Detect success/failure based on output
if echo "$login_output" | grep -q "Already Logged in"; then
    echo "✅ Successfully logged in to AtCoder."
else
    echo "❌ Login failed or REVEL_SESSION is missing/expired."
    echo "➡️  Please obtain your REVEL_SESSION cookie from your browser,"
    echo "    and paste it into .devcontainer/.env like this:"
    echo ""
    echo "    ATCODER_REVEL_SESSION=your_atcoder_session_here"
    echo ""
    echo "🛠 Then rebuild the container using 'Rebuild Container' in VSCode."
fi

# Sign in for Yukicoder if the API key is set
if [ -n "$YUKICODER_API_KEY" ]; then
    echo ""
    echo "🔐 Attempting cargo compete login yukicoder..."
    cargo compete login yukicoder
fi
