export PATH=$HOME/bin:/usr/local/bin:$PATH

#### general aliases
alias ls="ls -GFh"
alias containers="docker ps --format 'table {{.Names}}\t{{.Image}}'"
alias brprune="git branch -vv | awk '/: gone]/{if ($1!=\"*\") print $1}' | xargs git branch -d"

### shell stuff
# ls colors
export CLICOLOR=1
export LSCOLORS=Gxfxcxdxbxegedabagacad # OSX

# history size
export HISTFILESIZE=20000
export HISTSIZE=20000

# pure prompt
autoload -U promptinit; promptinit
prompt pure

# zsh syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
