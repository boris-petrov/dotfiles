local wezterm = require 'wezterm'

return {
  font = wezterm.font 'Inconsolata LGC',
  font_size = 15,

  scrollback_lines = 10000,
  enable_scroll_bar = true,

  colors = {
    cursor_bg = 'red',
  },
}
