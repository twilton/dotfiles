```
# twilton's dotfiles
```

This setup is intended for use with the [gruvbox colorscheme][gruvbox]
and the font [source code pro][source code pro] in the
[terminal][urxvt].

## what's included?

### zsh + tmux + vim
> aka _the trifecta_

#### leaders
```
tmux: <C-space>
vim: <space>
```
#### Navigation
panes (tmux) and windows (vim)
```
split horizontally: <leader>s
split vertically:   <leader>v
close focused:      <leader>c

focus west:  <leader>h
focus south: <leader>j
focus north: <leader>k
focus east:  <leader>l

increase current width:  <leader>H
decrease current height: <leader>J
increase current height: <leader>K
decrease current width:  <leader>H
```

windows (tmux) and buffers (vim)
```
focus prev: <leader>[
focus next: <leader>]
```

* [zsh](zsh/.zshrc)
* [tmux](tmux/.tmux.conf)
* [vim](vim/.vimrc)

### "But Wait, There's More!"
...

## installation

Clone the repo:
```bash
git clone git://github.com/twilton/dotfiles ~/.dotfiles
```
(Or, [fork and keep your fork
updated](http://robots.thoughtbot.com/keeping-a-github-fork-updated))

These files are managed with [GNU stow][stow]:
```bash
cd ~/.dotfiles
stow vim
```

[stow]: https://www.gnu.org/software/stow/
[urxvt]: http://software.schmorp.de/pkg/rxvt-unicode.html
