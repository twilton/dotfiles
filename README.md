# Dotfiles

```
OS: arch
Window Manager: bspwm
Terminal: urxvt
Terminal Font: [source code pro][source code pro] & [freetype2][font rendering]
Terminal color scheme: [gruvbox][gruvbox]
Text Editor: vim
Music Player: mpd
File Browser: ranger
Web Browser: firefox
```

# Install

Clone the repo:
```bash
git clone git://github.com/twilton/dotfiles ~/.dotfiles
```
(Or, [fork and keep your fork updated][fork])

This repo is managed with [GNU stow][stow]. For example, installing vim:
```bash
cd ~/.dotfiles
stow vim
```

[fork]: http://robots.thoughtbot.com/keeping-a-github-fork-updated
[stow]: https://www.gnu.org/software/stow/
[gruvbox]: https://github.com/morhetz/gruvbox
[source code pro]: https://github.com/adobe-fonts/source-code-pro
[font rendering]: https://gist.github.com/cryzed/e002e7057435f02cc7894b9e748c5671
