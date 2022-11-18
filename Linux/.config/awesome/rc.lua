-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")

-- remove borders when only a single window is visible
require("remborders")

local battery = require("obvious.battery")

local APW = require("apw/widget")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(awful.util.get_themes_dir() .. "default/theme.lua")
beautiful.border_focus = "#7fff00"

-- This is used later as the default terminal and editor to run.
terminal = "wezterm"
hostile_takeover = "gvim /home/boris/documents/Hostile\\ Takeover.txt"

alt_modkey = "Mod1"
win_modkey = "Mod4"

mainmenu = awful.menu({ items = { { "open terminal", terminal } } })

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.max,
    awful.layout.suit.fair,
}
-- }}}

-- Keyboard map indicator and switcher
local lts = { [0] = { [0] = " En ", [1] = "#ff0000" }, [1] = { [0] = " Bg ", [1] = "#00ff00" } }
mykeyboardlayout = awful.widget.keyboardlayout()
mykeyboardlayout._layout = { [1] = lts[0][0], [2] = lts[1][0] }
local kbdwidget = wibox.container.background()
kbdwidget:set_widget(mykeyboardlayout.widget)
kbdwidget:set_fg(lts[0][1])

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()
-- Calendar widget to attach to the textclock
local calendar2 = require('calendar2')
calendar2.addCalendarToWidget(mytextclock)

-- Separator widget
local separator_widget_text = wibox.widget.textbox()
separator_widget_text:set_text(" |")
local separator_widget = wibox.container.background()
separator_widget:set_widget(separator_widget_text)
separator_widget:set_fg("#ffff00")

-- Create a wibox for each screen and add it
local taglist_buttons = awful.util.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ }, 3, awful.tag.viewtoggle)
)

local tasklist_buttons = awful.util.table.join(
    awful.button({ }, 1, function (c)
                             -- Without this, the following
                             -- :isvisible() makes no sense
                             c.minimized = false
                             if not c:isvisible() and c.first_tag then
                                 c.first_tag:view_only()
                             end
                             -- This will also un-minimize
                             -- the client, if needed
                             client.focus = c
                             c:raise()
                         end)
)

local function set_wallpaper(s)
    -- Wallpaper
    beautiful.wallpaper = awful.util.getdir("config") .. "/themes/wallpaper.jpg"
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.centered(wallpaper, s, "000000") -- black background
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    local layouts = { awful.layout.layouts[1], awful.layout.layouts[1], awful.layout.layouts[1],
                      awful.layout.layouts[2], awful.layout.layouts[1], awful.layout.layouts[1],
                      awful.layout.layouts[1], awful.layout.layouts[1], awful.layout.layouts[1], }

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, layouts)

    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
        awful.button({ }, 1, function () awful.layout.inc( 1) end),
        awful.button({ }, 3, function () awful.layout.inc(-1) end),
        awful.button({ }, 4, function () awful.layout.inc( 1) end),
        awful.button({ }, 5, function () awful.layout.inc(-1) end)
    ))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    local rightwidgets = { -- Right widgets
        layout = wibox.layout.fixed.horizontal,
        APW,
    }
    if battery.get_data() then
        rightwidgets = awful.util.table.join(rightwidgets, {
            battery(),
            separator_widget,
        })
    end
    rightwidgets = awful.util.table.join(rightwidgets, {
        kbdwidget,
        wibox.widget.systray(),
        mytextclock,
        s.mylayoutbox,
    })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
        },
        s.mytasklist, -- Middle widget
        rightwidgets,
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ alt_modkey,           }, "Up",     APW.Up),
    awful.key({ alt_modkey,           }, "Down",   APW.Down),
    awful.key({ alt_modkey,           }, "m",      APW.ToggleMute),

    awful.key({ alt_modkey,           }, "l",      function() awful.spawn("xscreensaver-command -lock") end),

    awful.key({ alt_modkey,           }, "`",      awful.tag.history.restore),

    awful.key({ alt_modkey,           }, "j",      function () awful.client.focus.byidx( 1) end),
    awful.key({ alt_modkey,           }, "k",      function () awful.client.focus.byidx(-1) end),

    -- Layout manipulation
    awful.key({ alt_modkey, "Shift"   }, "j",      function () awful.client.swap.byidx(  1)    end),
    awful.key({ alt_modkey, "Shift"   }, "k",      function () awful.client.swap.byidx( -1)    end),
    awful.key({ alt_modkey, "Control" }, "j",      function () awful.screen.focus_relative( 1) end),
    awful.key({ alt_modkey, "Control" }, "k",      function () awful.screen.focus_relative(-1) end),
    awful.key({ alt_modkey,           }, "u",      awful.client.urgent.jumpto),
    awful.key({ alt_modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ alt_modkey,           }, "Return", function () awful.spawn(terminal) end),
    awful.key({ alt_modkey, "Shift"   }, "r",      awesome.restart),
    awful.key({ alt_modkey, "Shift"   }, "q",      awesome.quit),
    awful.key({ alt_modkey            }, "h",      function() awful.spawn(hostile_takeover) end)
)

clientkeys = awful.util.table.join(
    awful.key({ alt_modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end),
    awful.key({ alt_modkey,           }, "q",      function (c) c:kill()                         end),
    awful.key({ alt_modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ alt_modkey,           }, "o",      function (c) c:move_to_screen()               end),
    awful.key({ alt_modkey,           }, "a",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ alt_modkey,           }, "s",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ alt_modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Move client to tag.
        awful.key({ alt_modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                              tag:view_only()
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"})
    )
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ alt_modkey }, 1, awful.mouse.client.move),
    awful.button({ alt_modkey }, 3, awful.mouse.client.resize)
)

-- generate and add the 'run or raise' key bindings to the globalkeys table

local ror = function(klass, key, program)
    return awful.key({ win_modkey }, key, function()
        awful.client.run_or_raise(program, function(c)
            return awful.rules.match(c, { class = klass })
        end)
    end)
end

globalkeys = awful.util.table.join(globalkeys,
    ror("Firefox",           "f", "firefox"),
    ror("Chromium",          "c", "chromium"),
    ror("Deadbeef",          "w", "deadbeef"),
    ror("Deluge",            "b", "deluge"),
    ror("Clipboard History", "h", "xcmenuctrl")
)

-- Set keys
root.keys(globalkeys)
-- }}}

move_to_current_tag = function(c)
    if c.focus ~= nil then
        c.focus:move_to_tag(client.focus.screen.selected_tag)
    end
end

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
        properties = { border_width = beautiful.border_width,
                       border_color = beautiful.border_normal,
                       focus = awful.client.focus.filter,
                       raise = true,
                       keys = clientkeys,
                       buttons = clientbuttons,
                       screen = awful.screen.preferred,
                       placement = awful.placement.no_overlap+awful.placement.no_offscreen } },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Arandr",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Wpa_gui",
          "pinentry",
          "veromix",
          "xtightvncviewer",
          "cerebro",
        },

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to dialogs
    { rule_any = { instance = { "Dialog" }, type = { "dialog" } },
      properties = { titlebars_enabled = true },
      -- Don't move dialogs from the current tag
      callback = move_to_current_tag,
    },

    { rule_any = { class = { "firefox", "Chromium-browser", "Chromium" } },
      properties = { screen = 1, tag = "2", switchtotag = true } },
    { rule = { instance = "plugin-container" }, properties = { floating = true } }, -- Firefox Flash player
    { rule = { instance = "exe" },              properties = { floating = true } }, -- Chrome Flash player

    -- Chat
    { rule = { class = "Skype", name = "File Transfers" },
      properties = { screen = 1, tag = "4", focus = false, minimized = true } },
    { rule = { class = "Pidgin" },
      properties = { screen = 1, tag = "4", focus = false } },
    { rule = { class = "Pidgin", role = "buddy_list" },
        properties = { screen = 1, tag = "4", switchtotag = true, floating = true, focus = true,
                       maximized_vertical = true, maximized_horizontal = false },
        callback = function (c)
            local cl_width = 250  -- width of buddy list window
            local def_left = true -- default placement. note: you have to restart
                                  -- pidgin for changes to take effect

            local scr_area = client.focus.screen.workarea
            local cl_strut = c:struts()
            local geometry = nil

            -- adjust scr_area for this client's struts
            if cl_strut ~= nil then
                if cl_strut.left ~= nil and cl_strut.left > 0 then
                    geometry = { x = scr_area.x - cl_strut.left, y = scr_area.y,
                                 width = cl_strut.left }
                elseif cl_strut.right ~= nil and cl_strut.right > 0 then
                    geometry = { x = scr_area.x + scr_area.width, y = scr_area.y,
                                 width = cl_strut.right }
                end
            end
            -- scr_area is unaffected, so we can use the naive coordinates
            if geometry == nil then
                if def_left then
                    c:struts({ left = cl_width, right = 0 })
                    geometry = { x = scr_area.x, y = scr_area.y,
                                 width = cl_width }
                else
                    c:struts({ right = cl_width, left = 0 })
                    geometry = { x = scr_area.x + scr_area.width - cl_width, y = scr_area.y,
                                 width = cl_width }
                end
            end
            c:geometry(geometry)
        end },

    -- Music
    { rule = { class = "Deadbeef" },
      properties = { screen = 1, tag = "7" } },

    -- Mail
    { rule = { class = "thunderbird" },
      properties = { screen = screen.count(), tag = "8" } },
    { rule = { class = "thunderbird", name = "Attach File(s)" },
      callback = move_to_current_tag },
    { rule = { class = "thunderbird", instance = "Msgcompose" },
      callback = move_to_current_tag },

    -- Downloads
    { rule_any = { class = { "Deluge", "Flareget" } },
      properties = { screen = 1, tag = "9" } },
    { rule = { class = "Deluge", name = "Add Torrents" },
      callback = move_to_current_tag },
    { rule = { class = "Flareget", name = "New Download" },
      callback = move_to_current_tag },

    -- Other
    { rule = { class = "Luakit" },
      properties = { floating = true } },
    { rule_any = { class = { "Gvim", "URxvt" } },
      properties = { size_hints_honor = false } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = awful.util.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

client.connect_signal("manage", function(c, startup)
    if c.class == "Pidgin" and (not c.name or not c.name:match("Buddy List")) then
        -- Switch to the second layout for chat windows
        local start_dbus_send
        local change_language_on_focus
        start_dbus_send = function()
            awesome.disconnect_signal("refresh", start_dbus_send)
            awful.spawn("dbus-send --type=method_call --dest=ru.gentoo.KbddService /ru/gentoo/KbddService ru.gentoo.kbdd.set_layout uint32:1")
        end
        change_language_on_focus = function(cl)
            cl:disconnect_signal("focus", change_language_on_focus)
            awesome.connect_signal("refresh", start_dbus_send)
        end
        c:connect_signal("focus", change_language_on_focus)

        -- Do not signal a particular window
        if c.name and c.name:match("19:I2FpcmlhbjEvJDZlODBhMTI4NzZkOTNhOTM=@p2p.thread.skype") then
            c:connect_signal("property::urgent", function(cl) cl.urgent = false end)
        end
    end
end)

client.connect_signal("focus",   function(c) c.border_color = beautiful.border_focus  end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

awesome.connect_signal("xkb::group_changed", function ()
    local layout = awesome.xkb_get_layout_group()
    kbdwidget:set_fg(lts[layout][1])
end)

-- }}}
