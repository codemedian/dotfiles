
# Add homebrew completions to FPATH for command completions before enabling them
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# Enable bash command completion
autoload -Uz compinit && compinit

# Enable Cx-e edition of current terminal line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# Make 'Alt + ←' and 'ALT + →' jump words in terminal
bindkey '^[b' backward-word
bindkey '^[f' forward-word


alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias ls='ls -G'
alias ll='ls -la'
alias vim="vim -u $HOME/.config/vim/vimrc"

setopt PROMPT_SUBST # Needed to get the git prompt working

bindkey '^R' history-incremental-search-backward


# Load version control information
autoload -Uz vcs_info
function precmd() { vcs_info }
zstyle ':vcs_info:*' enable git

zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr '%F{167}!%f'
zstyle ':vcs_info:git:*' stagedstr '%F{106}+%f'
zstyle ':vcs_info:git:*' formats '%F{72}(%b%f%m%u%c%F{72})%f'
zstyle ':vcs_info:git:*' actionformats '(%F{241}(%a |%m)%f%m%u%c)'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked


+vi-git-untracked() {
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep -m 1 '^??' &>/dev/null
    then
        hook_com[misc]='%F{172}?%f'
    fi
}

# Automatically switch theme when OSX System theme changes
# 1. Function to apply the theme based on current system appearance
sync_terminal_theme() {
    local mode=$(defaults read -g AppleInterfaceStyle 2>/dev/null || echo "Light")
    if [[ "$mode" == "Dark" ]]; then
        local theme="gruvbox-dark"
    else
        local theme="gruvbox-light"
    fi
    # Apply to current tabs and set as default for new ones
    osascript -e "tell application \"Terminal\" to set current settings of tabs of windows to settings set \"$theme\""
    osascript -e "tell application \"Terminal\" to set default settings to settings set \"$theme\""
}

# 2. Run it once when you open a new terminal
sync_terminal_theme

# 3. Start a background listener ONLY if one isn't already running
if ! pgrep -f "sync_terminal_theme_loop" > /dev/null; then
    (
        # This is a named loop so pgrep can find it
        # It waits for the GlobalPreferences file to be 'touched' (happens on theme change)
        while true; do
            # Use zsh's built-in file monitoring via 'zstat' or a simple sleep
            # Sleep 3 is very low impact but responsive enough
            sync_terminal_theme
            sleep 3
        done
    ) >/dev/null 2>&1 &!
fi



PROMPT='%(?..%F{167}%?%f )%B%F{241}%~%f%b${vcs_info_msg_0_} %B%(!.#.%#)%b '


# Added by Antigravity
export PATH="/Users/chris/.antigravity/antigravity/bin:$PATH"

# OpenClaw Completion
source "/Users/chris/.openclaw/completions/openclaw.zsh"




function openclaw-start {
    launchctl enable gui/$(id -u)/ai.openclaw.gateway
    launchctl load ~/Library/LaunchAgents/ai.openclaw.gateway.plist
}

function openclaw-stop {
    launchctl unload ~/Library/LaunchAgents/ai.openclaw.gateway.plist
    launchctl disable gui/$(id -u)/ai.openclaw.gateway
}
