alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias ls='ls -G'
alias ll='ls -la'

setopt PROMPT_SUBST # Needed to get the git prompt working

# Load version control information
autoload -Uz vcs_info
function precmd() { vcs_info }
zstyle ':vcs_info:*' enable git

zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr '%F{167}!%f'
zstyle ':vcs_info:git:*' stagedstr '%F{106}+%f'
zstyle ':vcs_info:git:*' formats '%F{72}(%b%f%m%u%c%F{72})%f'
zstyle ':vcs_info:git:*' actionformats '(%F{237}(%a |%m)%f%m%u%c)'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked


+vi-git-untracked() {
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep -m 1 '^??' &>/dev/null
    then
        hook_com[misc]='%F{172}?%f'
    fi
}

PROMPT='%(?..%F{167}%?%f )%B%F{237}%~%f%b${vcs_info_msg_0_} %B%(!.#.%#)%b '
