# Dotfiles
|               |                                                            |
| ------------- | ---------------------------------------------------------- |
| **OS**        | [arch][info_os]                                            |
| **Shell**     | [bash][info_shell]                                         |
| **WM**        | [bspwm][info_wm]                                           |
| **Terminal**  | [urxvt][info_term]                                         |
| **Font**      | [source code pro][info_font] & [freetype2][font_rendering] |
| **Colors**    | [gruvbox][info_colors]                                     |
| **Theme**     | [arc][info_theme]                                          |
| **Icons**     | [surfn][info_icons]                                        |

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

# Preview

![Screenshot](https://github.com/twilton/dotfiles/raw/master/preview.png)

[info_os]: https://www.archlinux.org/
[info_shell]: https://www.gnu.org/software/bash/
[info_wm]: https://github.com/baskerville/bspwm
[info_term]: http://software.schmorp.de/pkg/rxvt-unicode.html
[info_font]: https://github.com/adobe-fonts/source-code-pro
[font_rendering]: https://gist.github.com/cryzed/e002e7057435f02cc7894b9e748c5671
[info_colors]: https://github.com/morhetz/gruvbox
[info_theme]: https://github.com/horst3180/Arc-theme
[info_icons]: https://github.com/erikdubois/Surfn
[fork]: http://robots.thoughtbot.com/keeping-a-github-fork-updated
[stow]: https://www.gnu.org/software/stow/
