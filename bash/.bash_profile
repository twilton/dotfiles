# -----------------------------------------------------------------------------
# .bash_profile
# Description: login bash shell config file
# -----------------------------------------------------------------------------
# Location: $HOME/.bash_profile
# -----------------------------------------------------------------------------

# Paths {{{
# XDG Base Directory Specification
# http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# Add local bin to path
export PATH="$HOME/.bin:$PATH"
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
    export VISUAL="$EDITOR"
fi

# Default Terminal
if [[ -x $(which urxvtc 2> /dev/null) ]]; then
    export TERMINAL='urxvtc'
fi

# Less options.
if [[ -x $(which less 2> /dev/null) ]]
then
    export LESS='-F -g -i -M -R -S -w -X -z-4'

    # colored man pages
    export LESS_TERMCAP_mb=$'\E[01;31m'
    export LESS_TERMCAP_md=$'\E[01;31m'
    export LESS_TERMCAP_me=$'\E[0m'
    export LESS_TERMCAP_se=$'\E[0m'
    export LESS_TERMCAP_so=$'\E[01;34;07m'
    export LESS_TERMCAP_ue=$'\E[0m'
    export LESS_TERMCAP_us=$'\E[01;32m'
fi

# use gcc colors
export GCC_COLORS=1
# }}}

# source .bashrc
if [[ -n "$BASH" ]] && [[ -r ~/.bashrc ]]; then
    . ~/.bashrc
fi

# start X at login
if [[ -z "$DISPLAY" ]] && [[ -n "$XDG_VTNR" ]] && [[ "$XDG_VTNR" -eq 1 ]]; then
  exec startx
fi

# vim:foldmethod=marker:foldlevel=0
