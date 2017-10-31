# -----------------------------------------------------------------------------
# Description: Colorscheme for ranger
# Location: $XDG_CONFIG_HOME/ranger/colorschemes/munsell.py
# -----------------------------------------------------------------------------

from __future__ import (absolute_import, division, print_function)

from ranger.colorschemes.default import Default
from ranger.gui.color import (
    black, red, green, yellow, blue, magenta, cyan, white,
    default, normal, bold, reverse,
    default_colors,
)

class Scheme(Default):
    progress_bar_color = white

    def use(self, context):
        fg, bg, attr = Default.use(self, context)

        if context.reset:
            pass

        elif context.in_browser:
            if context.selected:
                attr = normal
                bg = white
            if context.directory:
                fg = blue
            if context.media:
                fg = black
            if context.fifo or context.device:
                fg = magenta
            if context.main_column:
                if context.marked:
                    attr |= bold
                    fg = black

        elif context.in_titlebar:
            if context.tab:
                attr = normal
                bg = white
                if context.good:
                    bg = yellow

        elif context.in_statusbar:
            if context.marked:
                attr = normal
                bg = white
                fg = black

        return fg, bg, attr
