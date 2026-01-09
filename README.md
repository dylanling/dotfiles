# Dotfiles

Personal dotfiles for macOS with Zsh, managed via symlinks and a bootstrap script.

## Structure

```
dotfiles/
├── bootstrap.sh          # One-time setup script
├── Brewfile              # Homebrew packages
├── git/
│   ├── .gitconfig        # Git configuration with aliases and signing
│   ├── .gitconfig-work   # Work-specific overrides (gitignored)
│   └── .gitignore_global # Global git ignores
├── ohmyposh/
│   └── prompt.toml       # Oh My Posh prompt theme
└── zsh/
    ├── .zshrc            # Main Zsh configuration
    ├── .zsh_aliases      # Shell aliases
    ├── .zsh_env          # Environment variables (portable)
    ├── .zsh_env.local    # Machine-specific env (gitignored)
    ├── .zsh_runtimes     # Language runtime managers (nvm, rbenv)
    ├── .zsh_secrets      # API tokens (gitignored)
    ├── plugins.zsh       # Zinit plugin definitions
    └── completion.zsh    # Completion settings
```

## File Purposes

Quick reference for where to add new configuration:

| File | Purpose | When to modify |
|------|---------|----------------|
| `bootstrap.sh` | One-time setup script | Adding new symlinks or install steps |
| `Brewfile` | Homebrew packages | Adding CLI tools or apps |
| `.zshrc` | Shell initialization | Rarely - only for new source files |
| `.zsh_env` | Environment variables (portable) | PATH changes, locale settings |
| `.zsh_env.local` | Machine-specific env (gitignored) | Company-specific variables |
| `.zsh_aliases` | Shell aliases | New command shortcuts |
| `.zsh_runtimes` | Language version managers | Adding rbenv, nvm, pyenv, etc. |
| `.zsh_secrets` | API tokens (gitignored) | Credentials, tokens |
| `plugins.zsh` | Zinit plugin declarations | Adding/removing zsh plugins |
| `completion.zsh` | Completion settings | Completion behavior changes |
| `.gitconfig` | Git configuration | Git aliases, core settings |
| `.gitconfig-work` | Work git overrides (gitignored) | Work email, signing key |
| `.gitignore_global` | Global git ignores | Patterns to ignore in all repos |
| `prompt.toml` | Oh My Posh prompt theme | Prompt segments, colors, format |

## Features

### Shell (Zsh)

- **Plugin Manager**: [Zinit](https://github.com/zdharma-continuum/zinit) with turbo loading
- **Plugins**:
  - `fast-syntax-highlighting` - syntax highlighting
  - `zsh-autosuggestions` - fish-like suggestions
  - `zsh-history-substring-search` - history search
  - Oh My Zsh snippets for git and kubectl
- **Prompt**: [Oh My Posh](https://ohmyposh.dev/) with custom theme showing path, git status, and execution time
- **Tools**: fzf (fuzzy finder), zoxide (smart cd)
- **History**: 50k lines, shared across sessions, ignores duplicates and space-prefixed commands

### Git

- SSH commit signing via 1Password
- Automatic SSH URL rewriting for GitHub
- Useful aliases: `s`, `co`, `br`, `ci`, `cane`, `lo`, `a`, `cm`, `publish`, `mm`

### Runtime Managers

- **Node**: nvm (Homebrew or standalone)
- **Ruby**: rbenv

## Installation

```bash
git clone git@github.com:dling14/dotfiles.git ~/dotfiles
cd ~/dotfiles
./bootstrap.sh
```

The bootstrap script will:
1. Install Homebrew (if missing)
2. Install packages from the Brewfile (fzf, zoxide, nvm, rbenv, oh-my-posh, etc.)
3. Install Zinit plugin manager
4. Create symlinks for configs (`.zshrc`, `.gitconfig`, `.gitignore_global`, prompt)

After installation, create your secrets file:

```bash
$EDITOR ~/dotfiles/zsh/.zsh_secrets
```

Add any tokens needed (e.g., `GITHUB_TOKEN`, `ARTIFACTORY_READ_TOKEN`), then reload:

```bash
exec zsh
```

## Updating

Pull changes and re-run the bootstrap script to update symlinks:

```bash
cd ~/dotfiles
git pull
./bootstrap.sh
```
