#!/usr/bin/env bash
set -e

DOTFILES="$HOME/dotfiles"

# 1. Homebrew
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# 2. Install oh-my-posh and anything else
if ! command -v oh-my-posh >/dev/null 2>&1; then
  brew install jandedobbeleer/oh-my-posh/oh-my-posh
fi

# 3. Symlinks
ln -sf "$DOTFILES/zsh/zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES/git/gitconfig" "$HOME/.gitconfig"

mkdir -p "$HOME/.config/ohmyposh"
ln -sf "$DOTFILES/ohmyposh/prompt.toml" "$HOME/.config/ohmyposh/prompt.toml"

echo "✅ Dotfiles linked. Remember to create $DOTFILES/zsh/zsh_secrets on this machine."
