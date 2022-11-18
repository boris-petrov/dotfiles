local wezterm = require 'wezterm'

return {
  font = wezterm.font 'Inconsolata LGC',
  font_size = 15,

  scrollback_lines = 10000,
  enable_scroll_bar = true,

  colors = {
    cursor_bg = 'red',
  },

  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
}
