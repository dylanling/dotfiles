#!/usr/bin/env bash
set -e

DOTFILES="$HOME/dotfiles"

# 1. Homebrew
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# 2. Install tools from Brewfile
if [ -f "$DOTFILES/Brewfile" ]; then
  echo "Installing packages from Brewfile..."
  brew bundle --file="$DOTFILES/Brewfile"
fi

# 3. Install zinit
if [[ ! -f "${HOME}/.zinit/bin/zinit.zsh" ]]; then
  echo "Installing zinit..."
  mkdir -p "${HOME}/.zinit"
  git clone https://github.com/zdharma-continuum/zinit.git "${HOME}/.zinit/bin"
fi

# 4. Symlinks
ln -sf "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES/git/.gitignore_global" "$HOME/.gitignore_global"

# Work git config (optional - only if you've created one)
if [ -f "$DOTFILES/git/.gitconfig-work" ]; then
  ln -sf "$DOTFILES/git/.gitconfig-work" "$HOME/.gitconfig-work"
fi

mkdir -p "$HOME/.config/ohmyposh"
ln -sf "$DOTFILES/ohmyposh/prompt.toml" "$HOME/.config/ohmyposh/prompt.toml"


echo "✅ Dotfiles linked. Remember to create $DOTFILES/zsh/.zsh_secrets on this machine."
