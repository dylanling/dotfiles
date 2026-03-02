#!/usr/bin/env bash
set -e

DOTFILES="$HOME/dotfiles"
REPO="https://github.com/dotfiles/dotfiles.git"

# 1. Homebrew (installs Xcode CLT which includes git)
if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add brew to PATH for this session
  eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"
fi

# 2. Clone dotfiles if not present
if [ ! -d "$DOTFILES" ]; then
  echo "Cloning dotfiles..."
  git clone "$REPO" "$DOTFILES"
fi

# 3. Install tools from Brewfile
if [ -f "$DOTFILES/Brewfile" ]; then
  echo "Installing packages from Brewfile..."
  brew bundle --file="$DOTFILES/Brewfile"
fi

# 4. Install zinit
if [[ ! -f "${HOME}/.zinit/bin/zinit.zsh" ]]; then
  echo "Installing zinit..."
  mkdir -p "${HOME}/.zinit"
  git clone https://github.com/zdharma-continuum/zinit.git "${HOME}/.zinit/bin"
fi

# 5. Symlinks
ln -sf "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES/git/.gitignore_global" "$HOME/.gitignore_global"

# Work git config (optional - only if you've created one)
if [ -f "$DOTFILES/git/.gitconfig-work" ]; then
  ln -sf "$DOTFILES/git/.gitconfig-work" "$HOME/.gitconfig-work"
fi

# 6. Configure work git includeIf (if WORK_ORG is set)
# Source .zsh_env.local to get WORK_ORG if not already in environment
if [ -z "$WORK_ORG" ] && [ -f "$DOTFILES/zsh/.zsh_env.local" ]; then
  source "$DOTFILES/zsh/.zsh_env.local"
fi

if [ -n "$WORK_ORG" ]; then
  if ! grep -q "gitdir:~/dev/${WORK_ORG}/" "$HOME/.gitconfig" 2>/dev/null; then
    echo "Adding git includeIf for ~/dev/${WORK_ORG}/..."
    cat >> "$HOME/.gitconfig" << EOF

# Work-specific config for ${WORK_ORG}
[includeIf "gitdir:~/dev/${WORK_ORG}/"]
    path = ~/.gitconfig-work
EOF
  fi
fi

mkdir -p "$HOME/.config/ohmyposh"
ln -sf "$DOTFILES/ohmyposh/prompt.toml" "$HOME/.config/ohmyposh/prompt.toml"

mkdir -p "$HOME/.config/ghostty"
ln -sf "$DOTFILES/ghostty/config" "$HOME/.config/ghostty/config"

echo "Done! Remember to create $DOTFILES/zsh/.zsh_secrets on this machine."
