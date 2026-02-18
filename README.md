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
    ├── .zsh_runtimes     # Language runtime managers (asdf)
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
| `.zsh_runtimes` | Language version managers | asdf configuration and plugins |
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

- Automatic SSH URL rewriting for GitHub
- Useful aliases: `s`, `co`, `br`, `ci`, `cane`, `lo`, `a`, `cm`, `publish`, `mm`
- Work-specific config support via `includeIf` (see `.gitconfig-work.example`)

### Runtime Managers

- **asdf**: Universal version manager for Node, Ruby, Python, and more
  - Install plugins: `asdf plugin add nodejs`, `asdf plugin add ruby`
  - Install versions: `asdf install nodejs latest`, `asdf install ruby latest`
  - Set global versions: `asdf global nodejs latest`, `asdf global ruby latest`

## Installation

```bash
curl -fsSL https://raw.githubusercontent.com/dling14/dotfiles/main/bootstrap.sh | bash
```

The bootstrap script will:
1. Install Homebrew (if missing)
2. Clone the dotfiles repo to `~/dotfiles`
3. Install packages from the Brewfile (fzf, zoxide, asdf, oh-my-posh, etc.)
4. Install Zinit plugin manager
5. Create symlinks for configs (`.zshrc`, `.gitconfig`, `.gitignore_global`, prompt)
6. Configure git work directory (if `WORK_ORG` is set)

After installation, reload your shell:

```bash
exec zsh
```

### Work Configuration (Optional)

To set up work-specific git config (different email, signing, etc.):

1. Create `.zsh_env.local` with your org name:
   ```bash
   cp ~/dotfiles/zsh/.zsh_env.local.example ~/dotfiles/zsh/.zsh_env.local
   # Edit and set WORK_ORG="your-company"
   ```

2. Create `.gitconfig-work` with your work settings:
   ```bash
   cp ~/dotfiles/git/.gitconfig-work.example ~/dotfiles/git/.gitconfig-work
   # Edit with your work email, signing key, etc.
   ```

3. Re-run bootstrap to add the git `includeIf`:
   ```bash
   ./bootstrap.sh
   ```

This will apply `.gitconfig-work` to all repos under `~/dev/<WORK_ORG>/`.

## Updating

Pull changes and re-run the bootstrap script to update symlinks:

```bash
cd ~/dotfiles
git pull
./bootstrap.sh
```
