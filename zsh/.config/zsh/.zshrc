# completions
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

autoload -Uz compinit && compinit

# options
setopt PROMPT_SUBST # Needed for git prompt
setopt AUTO_CD      # cd to a directory by just typing its name

# history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE

# keybindings
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
bindkey '^[b' backward-word
bindkey '^[f' forward-word
bindkey '^R' history-incremental-search-backward

# aliases
alias ls='ls -G'
alias ll='ls -la'
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias vim='vim -u $HOME/.config/vim/vimrc'

# vcs_info setup for git prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' formats '%F{72}(%b%f%m%u%c%F{72})%f'
zstyle ':vcs_info:git:*' unstagedstr '%F{167}!%f'
zstyle ':vcs_info:git:*' stagedstr '%F{106}+%f'

# untracked files hook
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
+vi-git-untracked() {
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep -m 1 '^??' &>/dev/null
    then
        hook_com[misc]='%F{172}?%f'
    fi
}

precmd() { vcs_info }

# prompt
PROMPT='%(?..%F{167}%?%f )%B%F{241}%~%f%b${vcs_info_msg_0_} %B%(!.#.%#)%b '

# --- macOS Theme Sync Integration ---
# Sync the theme once on shell startup.
# The LaunchAgent handles theme changes for existing windows.
if [ -x "$HOME/.config/macos-theme-sync/sync.sh" ]; then
    "$HOME/.config/macos-theme-sync/sync.sh" >/dev/null 2>&1
fi
