# -----------------------------------------------------------------------------
# Name: zshrc
# Description: Config file for zsh
# Location: $HOME/.zshrc
# -----------------------------------------------------------------------------

# Skip for non-interactive shells
[[ -z "$PS1" ]] && return

# Environment {{{
# -----------------------------------------------------------------------------
# Paths {{{
# XDG Base Directory Specification
# http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# Set path
export PATH="$HOME/.bin:$PATH"

# History file
HISTFILE="$HOME/.zsh/history"
HISTSIZE=2000
SAVEHIST=2000
# }}}

# Encoding {{{
# Make UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
# }}}

# Programs {{{
# Default Browser
if [[ -x $(which firefox 2> /dev/null) ]]; then
    export BROWSER='firefox'
fi

# Default Editor
if [[ -x $(which vim 2> /dev/null) ]]; then
    export EDITOR='vim'
    export VISUAL=$EDITOR
fi

# Default Terminal
if [[ -x $(which urxvtc 2> /dev/null) ]]; then
    export TERMINAL='urxvtc'
fi

# Less options.
if [[ -x $(which less 2> /dev/null) ]]
then
    export LESS='-F -g -i -M -R -S -w -X -z-4'
fi

# use gcc colors
export GCC_COLORS=1

# colored man pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;34;07m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
# }}}

# Options {{{
# History options
setopt HIST_IGNORE_DUPS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
# Allow brace character class list expansion.
setopt BRACE_CCL
# Combine zero-length punctuation characters (accents) with the base character.
setopt COMBINING_CHARS
# Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.
setopt RC_QUOTES
# Don't error if globbing fails
setopt NONOMATCH
# Don't print a warning message if a mail file has been accessed.
unsetopt MAIL_WARNING
# List jobs in the long format by default.
setopt LONG_LIST_JOBS
# Attempt to resume existing job before creating a new process.
setopt AUTO_RESUME
# Report status of background jobs immediately.
setopt NOTIFY
# Don't run all background jobs at a lower priority.
unsetopt BG_NICE
# Don't kill jobs on shell exit.
unsetopt HUP
# Don't report on jobs when shell exit.
unsetopt CHECK_JOBS
# }}}
# -----------------------------------------------------------------------------
# }}}

# Plugins {{{
# -----------------------------------------------------------------------------
# Substring Search
source "$HOME/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh"
source "$HOME/.zsh/plugins/search.zsh"

# enable zsh completion menu
fpath=($HOME/.zsh/plugins/zsh-completions/src $fpath)
source "$HOME/.zsh/plugins/completion.zsh"

# enable visual mode in zle
source "$HOME/.zsh/plugins/zsh-vimode-visual/zsh-vimode-visual.zsh"

# enable coloring
autoload -U colors && colors
# -----------------------------------------------------------------------------
# }}}

# Keybinds {{{
# -----------------------------------------------------------------------------
# vi-like key bindings
bindkey -v
export KEYTIMEOUT=1

# Fix unmapped keys
# bindkey '\e[2~' quoted-insert # ins
bindkey '\e[3~' delete-char # del
bindkey '\e[7~' beginning-of-line # home
bindkey '\e[8~' end-of-line # end
bindkey '\e[5~' beginning-of-history # pg up
bindkey '\e[6~' end-of-history # pg down
# -----------------------------------------------------------------------------
# }}}

# Prompt {{{
# -----------------------------------------------------------------------------
# Update prompt info {{{
# current directory
function update_prompt_dir_info() {
    prompt_dir_info="%{$fg_no_bold[white]%}%~"
}

# current git branch
function update_prompt_git_info() {
    local prefix="%{$reset_color%}%{$fg[white]%}[ %{$reset_color%}"
    local suffix="%{$reset_color%}%{$fg[white]%} ]%{$reset_color%}"

    # get the current branch
    if [[ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" == "true" ]]; then
        local branch="${prefix}%{$fg[magenta]%}$(git symbolic-ref --short --quiet HEAD 2>/dev/null)${suffix}"
    fi

    prompt_git_info="${branch}"
}

# current keymap
function update_prompt_keymap_info() {
    local prefix="%{$reset_color%}%{$fg[white]%}[ %{$reset_color%}"
    local suffix="%{$reset_color%}%{$fg[white]%} ]%{$reset_color%}"

    # get the current keymap
    case $KEYMAP in
        main|viins)
            local mode="${prefix}%{$fg_bold[green]%}insert${suffix}"
            ;;
        vicmd)
            local mode="${prefix}%{$fg_bold[red]%}normal${suffix}"
            ;;
        vivis|vivli)
            local mode="${prefix}%{$fg_bold[blue]%}visual${suffix}"
            ;;
        # virep)
            # local mode="${prefix}%{$fg_bold[red]%}replace${suffix}"
            # ;;
        *)
            local mode="${prefix}%{$fg_bold[red]%}unknown${suffix}"
            ;;
    esac

    prompt_keymap_info="${mode}"
}
# }}}

# PROMPT {{{
function left_prompt {
    # set the color based on last command exit
    local prompt_error_check="%(?.%{$fg_bold[blue]%}.%{$fg_bold[red]%})"
    local prefix="%{$reset_color%}${prompt_error_check}[ %{$reset_color%}"
    local suffix="%{$reset_color%}${prompt_error_check} ] %{$reset_color%}"

    # set the left prompt
    PS1="${prefix}${prompt_dir_info}${suffix}"
    PS2="%{$reset_color%}${prompt_error_check}>%{$reset_color%}"
}
# }}}

# RPROMPT {{{
function right_prompt {
    # set the right prompt
    RPS1="${prompt_keymap_info}${prompt_git_info}"
    RPS2="${RPS1}"
}
# }}}

# reset prompts {{{
function reset_prompts {
    PS1=""
    PS2=""
    RPS1=""
    RPS2=""
}
# }}}

# special widgets {{{
# Executed every time the line eitor is started to read a new line of input
function zle-line-init {
    update_prompt_dir_info
    update_prompt_keymap_info
    update_prompt_git_info
    left_prompt
    right_prompt
    zle reset-prompt
}

# Executed every time the keymap changes
function zle-keymap-select {
    update_prompt_keymap_info
    right_prompt
    zle reset-prompt
}

# declare special widgets
zle -N zle-line-init
zle -N zle-keymap-select
zle -N edit-command-line
# }}}

# remove the useless space in the right prompt
ZLE_RPROMPT_INDENT=0

# clear prompt presets
reset_prompts
# -----------------------------------------------------------------------------
# }}}

# Aliases and functions {{{
# -----------------------------------------------------------------------------
# Headaches
alias quit='exit'
alias :q='quit'
alias pls='sudo $(fc -ln -1)'

# Add 'protection'
alias rm='rm -I'
alias cp='cp -vi'
alias mv='mv -i'

# Add sudo
alias mount='sudo mount'
alias umount='sudo umount'

# Directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Network
alias ping="ping -c 3"

# force colors
alias ls='ls --color=auto -hrtF'
alias lsa='ls --color=auto -oghrtF'
alias grep='grep --color=auto'

# Pacman / Pacaur
alias syugit='pacaur -Syu --devel --needed'

function sync_drive () {
    grive -p "${HOME}/google_drive/"
}

function keys () {
    kpcli --kdb "${HOME}/google_drive/Pass/cats.kdbx"
    echo "Don't forget to sync changes!"
}

# auto-ls after changing directory
cd () {
    builtin cd $@ && ls -hrtF
}

# make dir and cd into it
function mkcd ()
{
    mkdir -p "$@" && eval cd "\"\$$#\""
}

# make systemctl more friendly
alias ss='sudo systemctl'
compdef ss='systemctl'

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
# -----------------------------------------------------------------------------
# }}}

# vim:foldmethod=marker:foldlevel=0
