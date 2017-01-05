# dotfiles

## installation

These files are managed with [GNU stow][stow]

```bash
git clone git://github.com/twilton/dotfiles ~/.dotfiles
cd ~/.dotfiles
stow foo
```

For example,

```bash
stow vim
```

## What's included?

### zsh + tmux + vim
> aka _the trifecta_

This setup is intended for use in the [terminal][urxvt]

* [zsh][zsh]
* [tmux][tmux]
* [vim][vim]

### But Wait, There's More!

[stow]: https://www.gnu.org/software/stow/
[urxvt]: http://software.schmorp.de/pkg/rxvt-unicode.html
