local wezterm = require 'wezterm'

return {
  check_for_updates = false,

  font = wezterm.font 'Inconsolata LGC',
  font_size = 15,

  hide_tab_bar_if_only_one_tab = true,

  -- Makes font resizing work better in tiling window managers.
  adjust_window_size_when_changing_font_size = false,

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

  mouse_bindings = {
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'NONE',
      action = wezterm.action.CompleteSelection 'ClipboardAndPrimarySelection',
    },

    {
      event = { Up = { streak = 2, button = 'Left' } },
      mods = 'NONE',
      action = wezterm.action.CompleteSelection 'ClipboardAndPrimarySelection',
    },

    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CTRL',
      action = wezterm.action.OpenLinkAtMouseCursor,
    },
  },
}
