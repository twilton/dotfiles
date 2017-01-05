# dotfiles

This setup is intended for use in the [terminal][urxvt]

## what's included?

### zsh + tmux + vim
> aka _the trifecta_

* [zsh](zsh/.zshrc)
* [tmux](tmux/.tmux.conf)
* [vim](vim/.vimrc)

### "But Wait, There's More!"

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

[stow]: https://www.gnu.org/software/stow/
[urxvt]: http://software.schmorp.de/pkg/rxvt-unicode.html
