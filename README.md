# Dotfiles

```
OS: arch
Window Manager: bspwm
Terminal: urxvt
Terminal Font: source code pro
Terminal color scheme: gruvbox
Text Editor: vim
Music Player: mpd
File Browser: ranger
Web Browser: inox
```

# Installation

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

# Organization

## Directories

Each directory contains:
* Configuration files for a distinct package
* A structure of subdirectories dictated by [GNU stow][stow]
  compatibility
* A .gitignore ignoring all files other than tracked files for safe [GNU
  stow][stow] tree folding and unfolding

## Files

Each file contains:
* A comment section containing a short description and the proper location for the file
* Configurations categorized by vim folds (closed by default)

# UI

## Colors and font

* [gruvbox][gruvbox]
* [source code pro][source code pro]
* [freetype2][font rendering]

## Navigation

### Modifiers

```
tmux:  <C-space> ;
vim:   <space> ;
bspwm: <mod4>
```

### window (tmux), buffer (vim), desktop (bspwm)

```
focus prev: <modifier>[
focus next: <modifier>]
```

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
maximise current:        <modifier>+
```

# Audio

```
Application --> Pulseaudio --> ALSA --> Hardware
                |-- pamixer
                |---- paswitch
```

[stow]: https://www.gnu.org/software/stow/
[gruvbox]: https://github.com/morhetz/gruvbox
[source code pro]: https://github.com/adobe-fonts/source-code-pro
[font rendering]: https://gist.github.com/cryzed/e002e7057435f02cc7894b9e748c5671
