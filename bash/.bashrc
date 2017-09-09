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
shopt -qs checkwinsize
# History
shopt -s histappend
HISTCONTROL=ignoredups
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
# Colors {{{
function set_colors() {
    readonly COLOR_FG_BLACK="\[$(tput setaf 0)\]"
    readonly COLOR_FG_DARKGREY="\[$(tput setaf 8)\]"

    readonly COLOR_FG_DARKRED="\[$(tput setaf 1)\]"
    readonly COLOR_FG_RED="\[$(tput setaf 9)\]"

    readonly COLOR_FG_DARKGREEN="\[$(tput setaf 2)\]"
    readonly COLOR_FG_GREEN="\[$(tput setaf 10)\]"

    readonly COLOR_FG_DARKYELLOW="\[$(tput setaf 3)\]"
    readonly COLOR_FG_YELLOW="\[$(tput setaf 11)\]"

    readonly COLOR_FG_DARKBLUE="\[$(tput setaf 4)\]"
    readonly COLOR_FG_BLUE="\[$(tput setaf 12)\]"

    readonly COLOR_FG_DARKMAGENTA="\[$(tput setaf 5)\]"
    readonly COLOR_FG_MAGENTA="\[$(tput setaf 13)\]"

    readonly COLOR_FG_DARKCYAN="\[$(tput setaf 6)\]"
    readonly COLOR_FG_CYAN="\[$(tput setaf 14)\]"

    readonly COLOR_FG_LIGHTGREY="\[$(tput setaf 7)\]"
    readonly COLOR_FG_WHITE="\[$(tput setaf 15)\]"

    readonly COLOR_FG_DEFAULT="${COLOR_FG_LIGHTGREY}"

    readonly COLOR_RESET="\[$(tput sgr0)\]"
}
# }}}

# Hostname {{{
function prompt_hostname() {
    # check for ssh
    return

    local -r user="${COLOR_RESET}${COLOR_FG_GREEN}\\u${COLOR_RESET}"
    local -r host="${COLOR_RESET}${COLOR_FG_BLUE}\\h${COLOR_RESET}"
    local -r delimiter="${COLOR_RESET}${COLOR_FG_DEFAULT}@${COLOR_RESET}"

    echo "${user}${delimiter}${host} "
}
# }}}

# Directory {{{
function prompt_directory() {
    echo "${COLOR_FG_WHITE}\\w${COLOR_RESET}"
}
# }}}

# Git {{{
function prompt_git() {
    # check for git
    [[ -x "$(which git 2>/dev/null)" ]] || return
    # check for repo
    git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return

    # colors and symbols
    local -r branch_color="${COLOR_FG_MAGENTA}"
    local -r modified_color="${COLOR_FG_YELLOW}"
    local -r modified_symbol="*"
    local -r push_color="${COLOR_FG_WHITE}"
    local -r push_symbol="⇡"
    local -r pull_color="${COLOR_FG_WHITE}"
    local -r pull_symbol="⇣"

    # force git output in English
    local -r git_eng="env LANG=C git"
    # get current branch name or short SHA1 hash for detached head
    local -r branch="${COLOR_RESET}${branch_color}$($git_eng symbolic-ref --short HEAD 2>/dev/null ||
        $git_eng describe --tags --always 2>/dev/null)${COLOR_RESET}"
    # get number of commits local branch is ahead/behind of remote
    local -r stat="$($git_eng status --porcelain --branch | grep '^##' | grep -o '\[.\+\]$')"
    local -r ahead="$(echo $stat | grep -o 'ahead [[:digit:]]\+' | grep -o '[[:digit:]]\+')"
    local -r behind="$(echo $stat | grep -o 'behind [[:digit:]]\+' | grep -o '[[:digit:]]\+')"

    local symbols
    # if branch modified add symbol
    if [[ -n "$($git_eng status --porcelain)" ]]; then
        symbols+=" ${COLOR_RESET}${modified_color}${modified_symbol}${COLOR_RESET}"
    fi
    # if commits ahead/behind add symbol and num
    if [[ -n "$ahead" ]]; then
        symbols+=" ${COLOR_RESET}${push_color}${push_symbol}${ahead}${COLOR_RESET}"
    fi
    if [[ -n "$behind" ]]; then
        symbols+=" ${COLOR_RESET}${pull_color}${pull_symbol}${behind}${COLOR_RESET}"
    fi

    echo "${COLOR_RESET}${COLOR_FG_DEFAULT}:${branch}${symbols}${COLOR_RESET}"
}
# }}}

function build_prompt() {
    # Get the exit code of last command
    local -r exit_code="$?"
    # prompt prefix and suffix
    local -r prefix="${COLOR_RESET}${COLOR_FG_DEFAULT}[ ${COLOR_RESET}"
    local -r suffix="${COLOR_RESET}${COLOR_FG_DEFAULT} ]${COLOR_RESET}"
    # modules to add to prompt
    local -r modules="$(prompt_hostname)$(prompt_directory)$(prompt_git)"

    # Set privilege indicator color by exit code
    local prompt_privilege
    if [[ "${exit_code}" -eq "0" ]]; then
        prompt_privilege="${COLOR_RESET}${COLOR_FG_DEFAULT}\$${COLOR_RESET}"
    else
        prompt_privilege="${COLOR_RESET}${COLOR_FG_RED}\$${COLOR_RESET}"
    fi

    # Set the prompts
    PS1="${prefix}${modules}${suffix}${prompt_privilege} "
    PS2="${prefix}${COLOR_FG_YELLOW}>>>${COLOR_RESET}${suffix}${prompt_privilege} "
}

# Export colors to global variables for use in prompt
set_colors
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
