# --------------------------------------------------
# Paths
# --------------------------------------------------
export DOTFILES="$HOME/dotfiles"
export ZDOTDIR="$DOTFILES/zsh"

# --------------------------------------------------
# Base env
# --------------------------------------------------
if [ -f "$ZDOTDIR/.zsh_secrets" ]; then
  source "$ZDOTDIR/.zsh_secrets"
fi

if [ -f "$ZDOTDIR/.zsh_env" ]; then
  source "$ZDOTDIR/.zsh_env"
fi

# --------------------------------------------------
# History
# --------------------------------------------------
HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

# --------------------------------------------------
# Zinit (plugins)
# --------------------------------------------------
# Install zinit if missing (first-run friendly)
if [[ ! -f "${HOME}/.zinit/bin/zinit.zsh" ]]; then
  mkdir -p "${HOME}/.zinit"
  git clone https://github.com/zdharma-continuum/zinit.git "${HOME}/.zinit/bin"
fi

source "${HOME}/.zinit/bin/zinit.zsh"

# Load plugin definitions (separate file for sanity)
if [ -f "$ZDOTDIR/plugins.zsh" ]; then
  source "$ZDOTDIR/plugins.zsh"
fi

# --------------------------------------------------
# Prompt (Oh My Posh)
# --------------------------------------------------
# Make sure oh-my-posh is installed and on PATH
if command -v oh-my-posh >/dev/null 2>&1; then
  # Use your TOML config, with ~ properly expanded
  eval "$(oh-my-posh init zsh --config "$HOME/.config/ohmyposh/prompt.toml")"
fi

# --------------------------------------------------
# Completion / keybindings
# --------------------------------------------------
if [ -f "$ZDOTDIR/completion.zsh" ]; then
  source "$ZDOTDIR/completion.zsh"
fi

bindkey -e                    # emacs-style keybindings
setopt AUTO_CD
setopt CORRECT
setopt NO_BEEP

# Extra runtimes (SDKs, language managers, etc.)
if [ -f "$ZDOTDIR/.zsh_runtimes" ]; then
  source "$ZDOTDIR/.zsh_runtimes"
fi

# --------------------------------------------------
# fzf + zoxide
# --------------------------------------------------
# fzf integration (provided by fzf itself)
if command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --zsh)"

  # Optional: nicer defaults; tweak to taste
  if command -v fd >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  elif command -v rg >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden --follow -g "!*.git" 2>/dev/null'
  fi
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# zoxide integration
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
  alias zi='zoxide query -i'
fi

# --------------------------------------------------
# Aliases
# --------------------------------------------------
if [ -f "$ZDOTDIR/.zsh_aliases" ]; then
  source "$ZDOTDIR/.zsh_aliases"
fi
