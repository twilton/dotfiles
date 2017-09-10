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
# -----------------------------------------------------------------------------
# }}}

# Plugins {{{
# -----------------------------------------------------------------------------
# use bash completion if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion
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
alias mount='sudo mount'
alias umount='sudo umount'

# Directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# respect xdg standards
alias ncmpc="ncmpc -f $XDG_CONFIG_HOME/ncmpc/config"
alias tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"
# Pacman / Pacaur
alias syugit='pacaur -Syu --devel --needed'
# }}}

# Functions {{{
# google drive
function sync_drive () {
    grive -p "${HOME}/google_drive/"
}

# keepasscli
function keys () {
    kpcli --kdb "${HOME}/google_drive/Pass/cats.kdbx"
}

# make dir and cd into it
function mkcd ()
{
    mkdir -p "$@" && eval cd "\"\$$#\""
}

# easier extraction
extract () {
    if [ -f $1 ] ; then
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

# vim:foldmethod=marker:foldlevel=0
