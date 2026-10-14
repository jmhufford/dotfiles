# Repository Guidelines

## Project Structure & Module Organization

This repository is a chezmoi source directory for personal dotfiles. Root-level `dot_*` files map to files in the home directory; `dot_config/` contains application settings for Neovim, Hyprland, i3, Qtile, Waybar, and other tools. `bin/executable_*` files install as executable commands. Files ending in `.tmpl` are rendered by chezmoi using host and OS data from `.chezmoi.toml.tmpl`. `run_onchange_install-packages.sh.tmpl` installs dependencies when its rendered content changes. There is no separate application source, asset, or test directory.

## Development & Validation Commands

- `chezmoi diff` previews changes against the current home directory before applying them.
- `chezmoi apply` installs the rendered dotfiles locally; it can also run the package installation script, so review the diff first.
- `sh -n install.sh` checks the POSIX installer syntax; `bash -n bin/executable_askjeeves` checks a Bash utility.
- `EJSON_KEY=<key> ./install.sh` initializes and applies this source directory on a new machine. The README also documents a remote bootstrap command.

The chezmoi configuration requires `EJSON_KEY`. Template rendering also depends on the current host, OS, and installed system commands, so review changes on the platforms they affect.

## Coding Style & Naming Conventions

Follow the style of the file being edited: shell scripts use a shebang and `set -eu`, Python uses four-space indentation, and Lua follows the neighboring Neovim files. Use chezmoi naming prefixes such as `dot_`, `private_`, `readonly_`, and `executable_` to express destination names and permissions. Keep OS and host conditions inside templates where behavior differs. No repository-wide formatter or linter is configured.

## Testing Guidelines

There is no automated test suite or coverage target. Check syntax for edited scripts, inspect `chezmoi diff`, and manually verify affected shell startup, editor, or desktop behavior. For template changes, check rendering on each relevant host or OS before applying.

## Commits & Pull Requests

Recent commits use short, plain-English subjects such as `Limit fastfetch during shell startup` and `Rotate GitLab key in home.ejson`; there is no required prefix. Keep each commit focused and describe the behavior changed. In pull requests, state the affected applications and platforms, summarize validation, link any related issue, and include screenshots when desktop appearance changes.

## Secrets & Configuration

Keep secrets in encrypted `home.ejson` or `work.ejson` files. Never commit plaintext keys or paste `EJSON_KEY` into logs or review comments. Treat rendered diffs as potentially sensitive before sharing them.
