# -----------------------------------------------------------------------------
# .bash_profile
# Description: login bash shell config file
# -----------------------------------------------------------------------------
# Location: $HOME/.bash_profile
# -----------------------------------------------------------------------------

# Paths {{{
# XDG Base Directory Specification
#   http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
# user directories
#   XDG_RUNTIME_DIR is set by pam_systemd
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
# system directories
export XDG_DATA_DIRS="/usr/local/share:/usr/share"
export XDG_CONFIG_DIRS="/etc/xdg"

# Add local bin to path
export PATH="$HOME/.bin:$PATH"
# }}}

# Encoding {{{
# Make UTF-8
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
# }}}

# Programs {{{
# Default Browser
if [[ -x "$(which firefox 2> /dev/null)" ]]; then
    export BROWSER='firefox'
elif [[ -x "$(which chromium 2> /dev/null)" ]]; then
    export BROWSER='chromium'
fi

# Default Editor
if [[ -x "$(which vim 2> /dev/null)" ]]; then

    # make vim respect XDG
    if [[ -n "$XDG_CONFIG_HOME" ]] && [[ -r "$XDG_CONFIG_HOME/vim/vimrc" ]]; then
	# in EX command format
        export VIMINIT=":source $XDG_CONFIG_HOME/vim/vimrc"
    fi

    export EDITOR='vim'
    export VISUAL="$EDITOR"
fi

# Default Terminal
if [[ -x "$(which urxvtc 2> /dev/null)" ]]; then
    export TERMINAL='urxvtc'
fi

# Less options.
if [[ -x "$(which less 2> /dev/null)" ]]; then
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

# readline
if [[ -n "$XDG_CONFIG_HOME ]] && [[ -r "$XDG_CONFIG_HOME/readline/inputrc" ]]; then
    export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
fi
# }}}

# source .bashrc
if [[ -n "$BASH" ]] && [[ -r "$HOME/.bashrc" ]]; then
    . "$HOME/.bashrc"
fi

# start X at login
if [[ -z "$DISPLAY" ]] && [[ -n "$XDG_VTNR" ]] && [[ "$XDG_VTNR" -eq 1 ]]; then
  exec startx
fi

# vim:foldmethod=marker:foldlevel=0
