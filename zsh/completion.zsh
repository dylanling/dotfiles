# Ensure completion system is available
autoload -Uz compinit

# Cached compdump path
ZSH_COMPDUMP="${HOME}/.cache/zsh/.zcompdump"
mkdir -p "${HOME}/.cache/zsh"

# Initialize (use -C to skip some security checks in controlled env)
compinit -C -d "$ZSH_COMPDUMP"

# Completion settings
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
setopt AUTO_MENU
setopt MENU_COMPLETE

# Styles
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' '+m:{a-z}={-_}'
zstyle ':completion:*:descriptions' format '%F{yellow}%d%f'
zstyle ':completion:*' group-name ''

# Optional: case-insensitive and partial matches
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
