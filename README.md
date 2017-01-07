```
# twilton's dotfiles
```

# installation

Clone the repo:
```bash
git clone git://github.com/twilton/dotfiles ~/.dotfiles
```
(Or, [fork and keep your fork
updated](http://robots.thoughtbot.com/keeping-a-github-fork-updated))

This repo is managed with [GNU stow][stow]. For example, installing vim:
```bash
cd ~/.dotfiles
stow vim
```

# organization

## directories

Each directory has:
* Configuration files for a distinct package
* A structure of subdirectories dictated by [GNU stow][stow]
  compatibility
* A .gitignore ignoring all files other than tracked files for safe [GNU
  stow][stow] tree folding and unfolding

## formatting

Each file has
* A comment section containing a short description and the proper location for the file
* Configurations categorized by vim folds (closed by default)

# colors and font

Where applicable the [gruvbox][gruvbox] colorscheme and the font
[source code pro][source code pro] are used.

# mappings

## modifiers

```
tmux:  <C-space> ;
vim:   <space> ;
bspwm: <mod4>
```

## navigation

### pane (tmux), window (vim), node (bspwm)

```
split horizontally: <modifier>s
split vertically:   <modifier>v
close focused:      <modifier>c
```
```
focus west:  <modifier>h
focus south: <modifier>j
focus north: <modifier>k
focus east:  <modifier>l
```
```
increase current width:  <modifier>H
decrease current height: <modifier>J
increase current height: <modifier>K
decrease current width:  <modifier>H
```

### window (tmux), buffer (vim), desktop (bspwm)

```
focus prev: <modifier>[
focus next: <modifier>]
```

[stow]: https://www.gnu.org/software/stow/
[gruvbox]: https://github.com/morhetz/gruvbox
[source code pro]: https://github.com/adobe-fonts/source-code-pro
