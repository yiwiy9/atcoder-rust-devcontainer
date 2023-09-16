# 🏆🦀 AtCoder Rust Devcontainer

## 🌐 Overview

The `atcoder-rust-devcontainer` repository offers a tailored development environment for competitive programming in the Rust language, specifically for AtCoder contests. Utilizing a devcontainer setup, it simplifies the task of setting up and diving straight into coding challenges without the usual overhead of environment configuration.

## 🚀 Key Features, Benefits, and Available Tools

- **🔧 Integrated Toolset**: Equip yourself with general Rust tools like [rust-analyzer](https://github.com/rust-lang/rust-analyzer), [rustfmt](https://github.com/rust-lang/rustfmt), [clippy](https://github.com/rust-lang/rust-clippy), and the VS Code-specific debugger [vscode-lldb](https://github.com/vadimcn/codelldb). For competitive programming, this environment also integrates [cargo-compete](https://github.com/qryxip/cargo-compete) and [cargo-snippet](https://github.com/hatoo/cargo-snippet).

- **🌟 Hassle-Free Setup**: Bypass the tedious process of setting up tools individually. Jump directly into competitive programming with everything set up for you.

- **🔍 Optimized for Rust**: This devcontainer is fine-tuned for Rust, offering features such as auto-formatting, linting, and debugging for a smooth coding experience.

- **📦 Quick Code Snippets**: Leverage the integrated cargo-snippet to create and utilize Rust code snippets effortlessly in Visual Studio Code.

## 🛠 Prerequisites

- [Visual Studio Code](https://code.visualstudio.com/)
- [Docker](https://www.docker.com/)

## 🚶 Getting Started

📋 **Setting Up Your Environment**:

- Copy the `.devcontainer/.env.example` file to `.devcontainer/.env`.
- Inside the `.devcontainer/.env` file, make sure to set the following:
  - `ATCODER_USERNAME`: Replace with your AtCoder username.
  - `ATCODER_PASSWORD`: Replace with your AtCoder password.

After updating the values, you'll need to rebuild the devcontainer for the changes to take effect.

By configuring these values correctly, the devcontainer will be able to automatically sign you into the AtCoder platform upon successful rebuild.

## 🔑 Key Files and Usage

### `entrypoint.sh` 📄

This script initializes the development environment:

1. 🖇 Copies the example VS Code settings file for rust-analyzer to the appropriate location, if it doesn't already exist.
1. 📝 Generates Rust code snippets using `cargo_snippet.sh`.
1. 🔒 Automatically signs in to the AtCoder website with the provided username and password.

### `cargo_compete_new.sh` 📂

This script sets up a new contest directory and updates the rust-analyzer configuration in the VS Code settings.

#### 🚀 Usage

1. 🖥 Open the terminal within the devcontainer.
1. ▶ Run `cargo_compete_new.sh <contest>` where `<contest>` is the contest's name.

### `create_gitkeep_in_testcases.sh` 🖇

This script is a workaround for the issue detailed in [this PR](https://github.com/qryxip/cargo-compete/pull/198). It automates the creation of `.gitkeep` files within the `in/out` directories of the `cargo compete` testcases, ensuring that these directories are tracked by Git even if they are empty.

#### 🚀 Usage

1. 🖥 Open the terminal within the devcontainer.
1. ▶ Run the script by typing `./create_gitkeep_in_testcases.sh <path_to_project_directory>`.

The script will iterate over all `.yml` files in the `<path_to_project_directory>/testcases` directory and ensure that each corresponding `in/out` directory has a `.gitkeep` file.

### `cargo_snippet.sh` 🖇

This script generates Rust code snippets for Visual Studio Code, tailored for competitive programming. It allows you to create custom snippets in the `src/lib` directory and make them available for use within Visual Studio Code.

#### 🚀 Usage

1. 🖥 Open the terminal within the devcontainer.
1. ▶ Run the script by typing `cargo_snippet.sh`.

This updates the `rust.code-snippets` file in the `.vscode` directory, making your custom snippets available in Visual Studio Code.

## 🛠 Usage Examples

### 🏁 Setting up and Solving Problems (e.g., AtCoder Beginner Contest 317)

1. 📁 **Create a new contest directory**:
    - `cargo_compete_new.sh abc317`
1. 🚶 **Navigate to the created directory**:
    - `cd $WORKSPACE_FOLDER/src/contest/abc317/`
1. 📝 **Solving a Problem (e.g., Problem A)**:
    - 🧪 Execute sample test cases: `cargo compete test a`
    - 📤 Submit your solution: `cargo compete submit a`

### 🎯 Solving a Specific Problem (e.g., ABC317 problem a)

1. 🚶 **Navigate to your preferred directory**:
    - `cd $WORKSPACE_FOLDER/src/{your_directory_of_choice}`
1. ➕ **Add the desired problem**:
    - `cargo compete add abc317_a`
1. 🧪 **Execute sample test cases**:
    - `cargo compete test abc317_a`
1. 📤 **Submit your solution**:
    - `cargo compete submit abc317_a`

## 📜 License

This project is dual-licensed under MIT or Apache-2.0. For more details, see [LICENSE-MIT](LICENSE-MIT) and [LICENSE-APACHE](LICENSE-APACHE).
