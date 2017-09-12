# -----------------------------------------------------------------------------
# .bashrc
# Description: non-login bash shell config file
# -----------------------------------------------------------------------------
# Location: $HOME/.inputrc
# -----------------------------------------------------------------------------

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Options {{{
# -----------------------------------------------------------------------------
# use extended pattern matching
shopt -s extglob
# check window size after each command
shopt -s checkwinsize

# don't overwrite history
shopt -s histappend
# save multiline cmd as one history entry
shopt -s cmdhist
# increase history size
HISTSIZE=1000
# delete duplicate entries
HISTCONTROL=erasedups
# -----------------------------------------------------------------------------
# }}}

# Keybinds {{{
# -----------------------------------------------------------------------------
# vi-like key bindings
set -o vi
# -----------------------------------------------------------------------------
# }}}

# Prompt {{{
# -----------------------------------------------------------------------------
# Hostname {{{
function prompt_hostname() {
    return
    local -r user="\[\e[92m\]\\u"
    local -r host="\[\e[94m\]\\h"
    local -r separater="\[\e[37m\]@"

    echo "${user}${separater}${host} "
}
# }}}

# Directory {{{
function prompt_directory() {
    echo "\[\e[39m\]\\w"
}
# }}}

# Git {{{
function prompt_git() {
    # check for git
    [[ -x "$(which git 2>/dev/null)" ]] || return
    # check for repo
    git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return

    # force git output in English
    local -r git_eng="env LANG=C git"
    # get current branch name or short SHA1 hash for detached head
    local -r branch="$($git_eng symbolic-ref --short HEAD 2>/dev/null ||
        $git_eng describe --tags --always 2>/dev/null)"

    # : is lightgrey and branch is magenta
    echo "\[\e[37m\]:\[\e[95m\]${branch}"
}
# }}}

function build_prompt() {
    # Get the exit code of last command
    local -r exit_code="$?"

    # hack to have persistent history
    #   run in subshell to avoid triggering DEBUG
    (history -a)

    # modules to add to prompt
    local -r modules="$(prompt_hostname)$(prompt_directory)$(prompt_git)"

    # Set privilege indicator color by exit code
    local prompt_privilege
    if [[ "${exit_code}" -eq "0" ]]; then
        prompt_privilege="\[\e[39m\]\$"
    else
        prompt_privilege="\[\e[91m\]\$"
    fi

    # prompt prefix and suffix
    local -r prefix="\[\e[0m\]\[\e[37m\][ "
    local -r suffix="\[\e[37m\] ]${prompt_privilege}\[\e[0m\] "

    # Set the prompts
    PS1="${prefix}${modules}${suffix}"
    PS2="${prefix}\[\e[93m\]>>>${suffix}"
}

# Set the prompts
PROMPT_COMMAND=build_prompt
# -----------------------------------------------------------------------------
# }}}

# Aliases and functions {{{
# -----------------------------------------------------------------------------
# Builtins {{{
# auto-ls after changing directory
cd () {
    builtin cd "$@" && ls --color=auto -hrtF
}
# }}}

# Aliases {{{
# force colors
alias ls='ls --color=auto -hrtF'
alias lsa='ls --color=auto -ahrtF'
alias grep='grep --color=auto'

# Add 'protection'
alias rm='rm -I'
alias cp='cp -vi'
alias mv='mv -i'

# Limit ping
alias ping="ping -c 3"

# Headaches
alias quit='exit'
alias :q='exit'
alias pls='sudo $(fc -ln -1)'

# Directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Respect XDG Standards
if [[ -n "$XDG_CONFIG_HOME" ]]; then
    # ncmpc
    if [[ -x "$(which ncmpc 2> /dev/null)" ]] && [[ -r "$XDG_CONFIG_HOME/ncmpc/config" ]]; then
        alias ncmpc="ncmpc -f $XDG_CONFIG_HOME/ncmpc/config"
    fi

    # tmux
    if [[ -x "$(which tmux 2> /dev/null)" ]] && [[ -r "$XDG_CONFIG_HOME/tmux/tmux.conf" ]]; then
        alias tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"
    fi

    # redshift
    if [[ -x "$(which redshift 2> /dev/null)" ]] && [[ -r "$XDG_CONFIG_HOME/redshift/redshift.conf" ]]; then
        alias redshift="redshift -c $XDG_CONFIG_HOME/redshift/redshift.conf"
    fi
fi

# Pacman / Pacaur
if [[ -x "$(which pacaur 2> /dev/null)" ]]; then
    alias syugit='pacaur -Syu --devel --needed'
fi
# }}}

# Functions {{{
# google drive
function sync_drive () {
    if [[ -x "$(which grive 2> /dev/null)" ]]; then
        grive -p "$HOME/google_drive/"
    fi
}

# keepasscli
function keys () {
    if [[ -x "$(which kpcli 2> /dev/null)" ]]; then
        kpcli --kdb "$HOME/google_drive/Pass/cats.kdbx"

        # reset terminal
        reset
    fi
}

# make dir and cd into it
function mkcd ()
{
    mkdir -p "$@" && eval cd "\"\$$#\""
}

# easier extraction
extract () {
    if [[ -f "$1" ]]; then
        case $1 in
            *.tar.bz2) tar xvjf $1;;
            *.tar.gz) tar xvzf $1;;
            *.bz2) bunzip2 $1;;
            *.rar) unrar x $1;;
            *.gz) gunzip $1;;
            *.tar) tar xvf $1;;
            *.tbz2) tar xvjf $1;;
            *.tgz) tar xvzf $1;;
            *.zip) unzip $1;;
            *.Z) uncompress $1;;
            *.7z) 7za x $1;;
            *) echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
# }}}
# -----------------------------------------------------------------------------
# }}}

# Plugins {{{
# -----------------------------------------------------------------------------
# use bash completion if available
if [[ -n "$PS1" ]] && [[ -r '/usr/share/bash-completion/bash_completion' ]]; then
    . '/usr/share/bash-completion/bash_completion'
fi

# use fzf fuzzy finder if available
if [[ -n "$PS1" ]] && [[ -r '/usr/share/fzf/completion.bash' ]]; then
    . '/usr/share/fzf/completion.bash'

    # use provided keybinds in available
    #   need to be below `set -o vi` to preserve bindings
    if [[ -r '/usr/share/fzf/key-bindings.bash' ]]; then
        . '/usr/share/fzf/key-bindings.bash'
    fi

    # disable mouse and use 16 colors in fzf
    FZF_DEFAULT_OPTS='--no-mouse --color=16'

    # find hidden files, don't search .git
    #   prioritize ripgrep, ag, find
    if [[ -x "$(which rg 2> /dev/null)" ]]; then
        FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git}" 2> /dev/null'
        FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    elif [[ -x "$(which ag 2> /dev/null)" ]]; then
        FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
    fi
fi
# -----------------------------------------------------------------------------
# }}}

# vim:foldmethod=marker:foldlevel=0
