# -----------------------------------------------------------------------------
# zshrc
# Description: Config file for zsh
# -----------------------------------------------------------------------------
# Location: $HOME/.zshrc
# -----------------------------------------------------------------------------

# Skip for non-interactive shells
[[ -z "$PS1" ]] && return

# -----------------------------------------------------------------------------
# => Environment
# -----------------------------------------------------------------------------
# {{{
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

# History
HISTSIZE=2000
SAVEHIST=2000
HISTFILE="$HOME/.zsh/history"
setopt HIST_IGNORE_DUPS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# XDG Base Directory Specification
# http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# Set path
export PATH="$HOME/.bin:$PATH"

# Make UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

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

# Default Programs
if [[ -x $(which firefox 2> /dev/null) ]]; then
    export BROWSER='firefox'
fi
if [[ -x $(which vim 2> /dev/null) ]]; then
    export EDITOR='vim'
    export VISUAL=$EDITOR
fi
if [[ -x $(which urxvtc 2> /dev/null) ]]; then
    export TERMINAL='urxvtc'
fi

# Less options.
if [[ -x $(which less 2> /dev/null) ]]
then
    export LESS='-F -g -i -M -R -S -w -X -z-4'
fi
# }}}

# -----------------------------------------------------------------------------
# => Plugins
# -----------------------------------------------------------------------------
# {{{
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
# }}}

# -----------------------------------------------------------------------------
# => Keybinds
# -----------------------------------------------------------------------------
# {{{
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
# }}}

# -----------------------------------------------------------------------------
# => Prompt
# -----------------------------------------------------------------------------
# {{{
function zle-keymap-select zle-line-init zle-line-finish {
    local mode=""
    local git=""
    local prefix="%{$reset_color%}%{$fg[white]%}[ %{$reset_color%}"
    local suffix="%{$reset_color%}%{$fg[white]%} ]%{$reset_color%}"

    # get the current branch
    local branch
    branch="$(command git symbolic-ref --short --quiet HEAD 2>/dev/null)"
    if [[ $? -eq 0 ]]; then
       git="${prefix}%{$fg[magenta]%}${branch}${suffix}"
    fi

    case $KEYMAP in
        main|viins)
            mode="${prefix}%{$fg_bold[green]%}insert${suffix}"
            ;;
        vicmd)
            mode="${prefix}%{$fg_bold[red]%}normal${suffix}"
            ;;
        vivis|vivli)
            mode="${prefix}%{$fg_bold[blue]%}visual${suffix}"
            ;;
        # virep)
            # mode="${prefix}%{$fg_bold[red]%}replace${suffix}"
            # ;;
    esac

    RPS1="${mode}${git}"
    RPS2="${RPS1}"

    zle reset-prompt
}

# remove the useless space in the right prompt
ZLE_RPROMPT_INDENT=0

# set the color based on last command exit
prompt_error_check="%(?.%{$fg_bold[blue]%}.%{$fg_bold[red]%})"

# set the prompt init
PS1="%{$reset_color%}${prompt_error_check}[%{$fg_no_bold[white]%} %~ ${prompt_error_check}]%{$reset_color%} "
PS2="%{$reset_color%}${prompt_error_check}>%{$reset_color%} "
RPS1=""
RPS2=""

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
zle -N edit-command-line
# }}}

# -----------------------------------------------------------------------------
# => Aliases and functions
# -----------------------------------------------------------------------------
# {{{
# Headaches
alias quit='exit'
alias :q='quit'
alias pls='sudo $(fc -ln -1)'

# Shortforms
alias c='clear'
alias s='sudo'

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

# Network
alias ping="ping -c 3"

# force colors
alias ls='ls --color=auto -hrtF'
alias lsa='ls --color=auto -oghrtF'
alias grep='grep --color=auto'

# Pacman / Pacaur
alias syugit='pacaur -Syu --devel --needed'

# passwords
alias keys="kpcli --kdb ${HOME}/documents/local/cats"

# auto-ls after changing directory
cd () {
    builtin cd $@ && ls -hrtF
}

# make dir and cd into it
function mkcd ()
{
    mkdir -p "$@" && eval cd "\"\$$#\"";
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
# }}}

# vim:foldmethod=marker:foldlevel=0
