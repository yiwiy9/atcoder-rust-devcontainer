# 🏆🦀 AtCoder Rust Devcontainer

[![CI](https://github.com/yiwiy9/atcoder-rust-devcontainer/actions/workflows/ci.yml/badge.svg)](https://github.com/yiwiy9/atcoder-rust-devcontainer/actions)
[![License: MIT OR Apache-2.0](https://img.shields.io/badge/license-MIT_OR_Apache--2.0-blue)](#-license)

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
  - `ATCODER_REVEL_SESSION`: Replace with your AtCoder Session Cookie.

After updating the values, you'll need to rebuild the devcontainer for the changes to take effect.

By configuring these values correctly, the devcontainer will be able to automatically sign you into the AtCoder platform upon successful rebuild.

> 💡 How to get your `REVEL_SESSION` cookie: See the [aclogin README (Japanese)](https://github.com/key-moon/aclogin/blob/main/README.md).

## 🔑 Key Files and Usage

### `entrypoint.sh` 📄

This script initializes the development environment:

1. 🖇 Copies the example VS Code settings file for rust-analyzer to the appropriate location, if it doesn't already exist.
1. 📝 Generates Rust code snippets using `cargo_snippet.sh`.
1. 🔒 Writes the AtCoder session cookie (`REVEL_SESSION`) and attempts login via `cargo compete login atcoder`.

### `cargo_compete_new.sh` 📂

This script sets up a new contest directory and updates the rust-analyzer configuration in the VS Code settings.

#### 🚀 Usage

1. 🖥 Open the terminal within the devcontainer.
1. ▶ Run `cargo_compete_new.sh <contest>` where `<contest>` is the contest's name.

### `create_gitkeep_in_testcases.sh` 📂

This script is a workaround for the issue detailed in [qryxip/cargo-compete#198](https://github.com/qryxip/cargo-compete/pull/198). It automates the creation of `.gitkeep` files within the `in/out` directories of the `cargo compete` testcases, ensuring that these directories are tracked by Git even if they are empty.

#### 🚀 Usage

1. 🖥 Open the terminal within the devcontainer.
1. ▶ Run the script by typing `create_gitkeep_in_testcases.sh <path_to_contest_directory>`.

The script will iterate over all `.yml` files in the `<path_to_contest_directory>/testcases` directory and ensure that each corresponding `in/out` directory has a `.gitkeep` file.

📝 **Note**:

- When you execute `cargo_compete_new.sh`, the `create_gitkeep_in_testcases.sh` script is automatically run for the new contest directory.
- If you're using `cargo compete add` to add problems, you'll need to run `create_gitkeep_in_testcases.sh` manually for the specific contest directory.

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

### 🌟 Yukicoder Support

This setup also supports solving problems from [yukicoder](https://yukicoder.me). Follow these steps to set up your environment and submit your solutions:

#### ⚠ Important Note: Differences in Execution Environments

The execution environments for AtCoder and yukicoder are different. While AtCoder allows the use of most Rust crates, yukicoder imposes stricter restrictions on the available crates. Before using a crate in your solution, ensure it is supported in yukicoder's environment. You can refer to yukicoder's [execution environment documentation](https://yukicoder.me/help/environments) for details.

#### 📋 Setting Up for Yukicoder

1. **Environment Variable**:
   - If you'd like to use the Yukicoder API, set the following environment variable in `.devcontainer/.env`:

   ```bash
   YUKICODER_API_KEY=your_api_key
   ```

    - This key is optional but necessary if you're using features that rely on the Yukicoder API.

2. **Rebuild the Devcontainer**:
   After setting the API key, rebuild the devcontainer for the changes to take effect:

   ```bash
   Ctrl+Shift+P -> Dev Containers: Rebuild Container
   ```

#### ➕ Adding Problems

To add a yukicoder problem, include `"yukicoder"` as the second argument when using the `add` command:

```bash
cargo compete add <problem_id> yukicoder
```

#### 📤 Submission

Before submitting to yukicoder, update the `language_id` in the `[submit]` section of `compete.toml`. Replace the default value with `"rust"`:

```toml
[submit]
kind = "file"
path = "{{ src_path }}"
# language_id = "4050" # Rust 1.42.0
# language_id = "5054" # Rust 1.70.0
language_id = "rust" # for yukicoder
```

After updating `compete.toml`, you can submit the solution as usual:

```bash
cargo compete submit <problem_id>
```

## 📜 License

This project is dual-licensed under MIT or Apache-2.0. For more details, see [LICENSE-MIT](LICENSE-MIT) and [LICENSE-APACHE](LICENSE-APACHE).
