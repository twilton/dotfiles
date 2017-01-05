```
# twilton's dotfiles
```

This setup is intended for use in the [terminal][urxvt]

## what's included?

### zsh + tmux + vim
> aka _the trifecta_

* [zsh](zsh/.zshrc)
* [tmux](tmux/.tmux.conf)
* [vim](vim/.vimrc)

### "But Wait, There's More!"

## installation

Clone the repo:
```bash
git clone git://github.com/twilton/dotfiles ~/.dotfiles
```
(Or, [fork and keep your fork
updated](http://robots.thoughtbot.com/keeping-a-github-fork-updated))

These files are managed with [GNU stow][stow]

For example,
```bash
cd ~/.dotfiles
stow vim
```

[stow]: https://www.gnu.org/software/stow/
[urxvt]: http://software.schmorp.de/pkg/rxvt-unicode.html
