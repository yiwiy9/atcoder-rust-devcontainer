# AtCoder Rust Devcontainer

## Overview

The `atcoder-rust-devcontainer` repository provides a pre-configured development environment for the Rust programming language, optimized for participating in AtCoder competitions. This environment leverages cargo-compete on a devcontainer, streamlining the process of setting up and participating in competitive programming challenges.

## Getting Started

Copy the `.devcontainer/.env.example` file to `.devcontainer/.env` and customize the values as needed.

## Key Files and Usage

### `snippet.sh`

This script generates Rust code snippets for Visual Studio Code, tailored for competitive programming. It allows you to create custom snippets in the src/lib directory and make them available for use within Visual Studio Code.

#### Usage

1. Open the terminal within the devcontainer.
1. Run `snippet.sh` by typing `snippet.sh` and pressing `Enter`.

This will create or update the `rust.code-snippets` file in the `.vscode` directory of the workspace folder, making your custom snippets available for use in Visual Studio Code.
