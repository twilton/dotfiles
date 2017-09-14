# -----------------------------------------------------------------------------
# .bash_profile
# Description: login bash shell config file
# -----------------------------------------------------------------------------
# Location: $HOME/.bash_profile
# -----------------------------------------------------------------------------

# XDG {{{
# Base Directories {{{
# http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
#   XDG_RUNTIME_DIR is set by pam_systemd
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_DIRS="/usr/local/share:/usr/share"
export XDG_CONFIG_DIRS="/etc/xdg"
# }}}

# XDG_RUNTIME_DIR ENV Var {{{
if [[ -n "$XDG_RUNTIME_DIR" ]]; then
    # urxvt
    if [[ -x "$(which urxvtd 2> /dev/null)" ]]; then
        export RXVT_SOCKET="$XDG_RUNTIME_DIR/urxvtd"
    fi

    # tmux
    if [[ -x "$(which tmux 2> /dev/null)" ]]; then
        export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
    fi
fi
# }}}

# XDG_CONFIG_HOME ENV Var {{{
if [[ -n "$XDG_CONFIG_HOME" ]]; then
    # adb
    if [[ -x "$(which adb 2> /dev/null)" ]]; then
        export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
    fi

    # gimp
    if [[ -x "$(which gimp 2> /dev/null)" ]]; then
        export GIMP2_DIRECTORY="$XDG_CONFIG_HOME/gimp"
    fi

    # gpg
    if [[ -x "$(which gpg 2> /dev/null)" ]]; then
        export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
    fi

    # gtk 1
    export GTK_RC_FILES="$XDG_CONFIG_HOME/gtk-1.0/gtkrc"
    # gtk 2
    export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"

    # less
    if [[ -x "$(which less 2> /dev/null)" ]]; then
        # set less key config
        export LESSKEY="$XDG_CONFIG_HOME/less/lesskey"
    fi

    # readline
    export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"

    # vim
    if [[ -x "$(which vim 2> /dev/null)" ]]; then
        # in EX command format
        export VIMINIT=":source $XDG_CONFIG_HOME/vim/vimrc"
    fi

    # wget
    if [[ -x "$(which vim 2> /dev/null)" ]]; then
        export WGETRC="$XDG_CONFIG_HOME/wgetrc"
    fi
fi
# }}}

# XDG_CACHE_HOME ENV Var {{{
if [[ -n "$XDG_CACHE_HOME" ]]; then
    # less
    if [[ -x "$(which less 2> /dev/null)" ]]; then
        if [[ -w "$XDG_CACHE_HOME" ]] && [[ ! -d "$XDG_CACHE_HOME/less" ]]; then
            mkdir "$XDG_CACHE_HOME/less"
        fi

        # set less history file
        export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
    fi
fi
# }}}

# XDG_DATA_HOME ENV Var {{{
if [[ -n "$XDG_DATA_HOME" ]]; then
    # rust
    if [[ -x "$(which cargo 2> /dev/null)" ]]; then
        export CARGO_HOME="$XDG_DATA_HOME/cargo"
    fi

    # openssl
    if [[ -x "$(which openssl 2> /dev/null)" ]]; then
        export RANDFILE="$XDG_DATA_HOME/openssl/.rnd"
    fi

    # pass
    if [[ -x "$(which pass 2> /dev/null)" ]]; then
        export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"
    fi
fi
# }}}
# }}}

# Paths {{{
# Add local bin to path
export PATH="$HOME/.local/bin:$PATH"
# }}}

# Encoding {{{
# Make UTF-8
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
# }}}

# Programs {{{
# Defaults {{{
# Browser
if [[ -x "$(which firefox 2> /dev/null)" ]]; then
    export BROWSER='firefox'
elif [[ -x "$(which chromium 2> /dev/null)" ]]; then
    export BROWSER='chromium'
fi

# Editor
if [[ -x "$(which vim 2> /dev/null)" ]]; then
    export EDITOR='vim'
    export VISUAL="$EDITOR"
fi

# Terminal
if [[ -x "$(which urxvtc 2> /dev/null)" ]]; then
    export TERMINAL='urxvtc'
fi
# }}}

# Options {{{
# gcc
export GCC_COLORS=1

# less
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
# }}}
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
