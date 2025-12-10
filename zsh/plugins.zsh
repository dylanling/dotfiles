# ---- Oh My Zsh libs via zinit (no OMZ install needed) ----
zinit light-mode for \
  OMZ::lib/git.zsh \
  OMZ::lib/theme-and-appearance.zsh

# ---- Core plugins (with turbo loading) ----

# # Fast syntax highlighting (load early-ish)
zinit ice wait"0" lucid
zinit light zdharma-continuum/fast-syntax-highlighting

# # Autosuggestions
zinit ice wait"1" lucid
zinit light zsh-users/zsh-autosuggestions

# # History substring search
zinit ice wait"2" lucid
zinit light zsh-users/zsh-history-substring-search

# # ---- Optional OMZ plugin snippets ----
# # Add/remove to taste:
zinit snippet OMZP::git
zinit snippet OMZP::kubectl
