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
-- load the 'run or raise' function
local ror = require("aweror")
-- remove borders when only a single window is visible
require("remborders")

require("utils")

local vicious = require("vicious")

require("awful.remote")
require("screenful/screenful")

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
    awesome.connect_signal("debug::error", function(err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init(awful.util.getdir("config") .. "/themes/default/theme.lua")

terminal         = "urxvt"
hostile_takeover = "gvim /home/boris/documents/Hostile\\ Takeover.txt"

alt_modkey = "Mod1"
win_modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.fair,
    awful.layout.suit.max,
    -- awful.layout.suit.floating,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier
}
-- }}}

-- {{{ Wallpaper
beautiful.wallpaper = awful.util.getdir("config") .. "/themes/wallpaper.jpg"
for s = 1, screen.count() do
    gears.wallpaper.centered(beautiful.wallpaper, s)
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {
    layouts = { layouts[4], layouts[4], layouts[4], layouts[3], layouts[2],
                layouts[4], layouts[4], layouts[4], layouts[4] }
}

for s = 1, screen.count() do
    tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, tags.layouts)
end
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock()
-- Calendar widget to attach to the textclock
local calendar2 = require('calendar2')
calendar2.addCalendarToWidget(mytextclock)

-- Create a systray
mysystray = wibox.widget.systray()

-- Keyboard layout widget
kbdwidget = wibox.widget.textbox()
kbdwidget:set_text(" En ")

-- Battery widget
if directoryExists('/sys/class/power_supply/BAT0') then
    batwidget = wibox.widget.textbox()
    vicious.register(batwidget, vicious.widgets.bat, "$2% - $3 |", 61, "BAT0")
else
    batwidget = nil
end

-- Create a wibox for each screen and add it
mywibox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                        awful.button({}, 1, awful.tag.viewonly)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({}, 1, function(c)
                                              -- This will also un-minimize
                                              -- the client, if needed
                                              client.focus = c
                                              c:raise()
                                          end))

for s = 1, screen.count() do
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function() awful.layout.inc(layouts,  1) end),
                           awful.button({ }, 3, function() awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mytaglist[s])
    left_layout:add(mylayoutbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if batwidget ~= nil then right_layout:add(batwidget) end
    right_layout:add(kbdwidget)
    if s == 1 then right_layout:add(mysystray) end
    right_layout:add(mytextclock)

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ alt_modkey }, "l", function() awful.util.spawn("xlock -mode blank") end),

    awful.key({ alt_modkey }, "`", awful.tag.history.restore),

    awful.key({ alt_modkey }, "j",
        function()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ alt_modkey }, "k",
        function()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),

    -- Layout manipulation
    awful.key({ alt_modkey, "Shift"   }, "j", function() awful.client.swap.byidx( 1)     end),
    awful.key({ alt_modkey, "Shift"   }, "k", function() awful.client.swap.byidx(-1)     end),
    awful.key({ alt_modkey, "Control" }, "j", function() awful.screen.focus_relative( 1) end),
    awful.key({ alt_modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end),
    awful.key({ alt_modkey,           }, "u", awful.client.urgent.jumpto),

    -- Standard program
    awful.key({ alt_modkey,         }, "Return", function() awful.util.spawn(terminal) end),
    awful.key({ alt_modkey, "Shift" }, "r",      awesome.restart),
    awful.key({ alt_modkey, "Shift" }, "q",      awesome.quit),
    awful.key({ alt_modkey          }, "h",      function() awful.util.spawn(hostile_takeover) end),

    -- awful.key({ alt_modkey,           }, "l",     function() awful.tag.incmwfact( 0.05)   end),
    -- awful.key({ alt_modkey,           }, "h",     function() awful.tag.incmwfact(-0.05)   end),
    awful.key({ alt_modkey, "Shift"   }, "h",     function() awful.tag.incnmaster( 1)     end),
    awful.key({ alt_modkey, "Shift"   }, "l",     function() awful.tag.incnmaster(-1)     end),
    awful.key({ alt_modkey, "Control" }, "h",     function() awful.tag.incncol( 1)        end),
    awful.key({ alt_modkey, "Control" }, "l",     function() awful.tag.incncol(-1)        end),
    awful.key({ alt_modkey, "Control" }, "space", function() awful.layout.inc(layouts, 1) end)
)

clientkeys = awful.util.table.join(
    awful.key({ alt_modkey,                    }, "f",      function(c) c.fullscreen = not c.fullscreen  end),
    awful.key({ alt_modkey,                    }, "q",      function(c) c:kill()                         end),
    awful.key({ alt_modkey, "Control", "Shift" }, "f",      awful.client.floating.toggle                     ),
    awful.key({ alt_modkey, "Control", "Shift" }, "Return", function(c) c:swap(awful.client.getmaster()) end),
    awful.key({ alt_modkey,                    }, "o",      awful.client.movetoscreen                        ),
    -- awful.key({ alt_modkey, "Shift"            }, "r",      function(c) c:redraw()                       end),
    awful.key({ alt_modkey,                    }, "a",      function(c) c.minimized = true               end),
    awful.key({ alt_modkey,                    }, "s",
        function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber))
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ alt_modkey }, "#" .. i + 9,
                  function()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ alt_modkey, "Shift" }, "#" .. i + 9,
                  function()
                      if client.focus and tags[client.focus.screen][i] then
                          tag = tags[client.focus.screen][i]
                          awful.client.movetotag(tag)
                          awful.tag.viewonly(tag)
                      end
                  end),
        awful.key({ alt_modkey, "Control", "Shift" }, "#" .. i + 9,
                  function()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ },            1, function(c) client.focus = c; c:raise() end),
    awful.button({ alt_modkey }, 1, awful.mouse.client.move),
    awful.button({ alt_modkey }, 3, awful.mouse.client.resize)
)

-- generate and add the 'run or raise' key bindings to the globalkeys table
globalkeys = awful.util.table.join(globalkeys, ror.genkeys(win_modkey))

-- Set keys
root.keys(globalkeys)
-- }}}

move_to_current_tag = function(c)
    awful.client.movetotag(tags[mouse.screen][awful.tag.getidx()], c)
end

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus        = true,
                     keys         = clientkeys,
                     buttons      = clientbuttons } },
    { rule = { class = "Firefox" },
      properties = { tag = tags[1][2], switchtotag = true } },
    { rule = { class = "Firefox", instance = "Dialog", name = "Password Required" },
      properties = { switchtotag = false } },
    { rule = { class = "Plugin-container" },  properties = { floating = true } }, -- Firefox Flash player
    { rule = { class = "Exe", name = "exe" }, properties = { floating = true } }, -- Chrome Flash player
    -- { rule = { class = "Firefox", instance = "Dialog" },
        --   callback = move_to_current_tag },
    { rule = { class = "Skype", name = "File Transfers" },
      properties = { tag = tags[1][4], focus = false, minimized = true } },
    { rule = { class = "Pidgin" },
      properties = { focus = false },
      callback = function(c)
          -- just specifying "tag = ..." doesn't work on multiple monitors
          awful.client.movetotag(tags[1][4], c)
      end },
    { rule = { class = "Deadbeef" },
      properties = { tag = tags[1][7] } },
    { rule = { class = "Thunderbird" },
      properties = { tag = tags[screen.count()][8] } },
    { rule = { class = "Thunderbird", name = "Attach File(s)" },
      callback = move_to_current_tag },
    { rule = { class = "Deluge" },
      properties = { tag = tags[1][9] } },
    { rule = { class = "Deluge", name = "Add Torrents" },
      callback = move_to_current_tag },
    { rule = { class = "Luakit" },
      properties = { floating = true } },
    { rule = { class = "Gvim" },
      properties = { size_hints_honor = false } },
    { rule = { class = "URxvt" },
      properties = { size_hints_honor = false } }
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c, startup)
    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

-- Do not signal a particular window
client.connect_signal("manage", function(c, startup)
    if c.class == "Pidgin" and c.name and c.name:match("#airian") then
        c:connect_signal("property::urgent", function(cl)
            cl.urgent = false
        end)
    end
end)

client.connect_signal("focus",   function(c) c.border_color = beautiful.border_focus  end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

lts = { [0] = " En ", [1] = " Bg " }

dbus.request_name("session", "ru.gentoo.kbdd")
dbus.add_match("session", "interface='ru.gentoo.kbdd',member='layoutChanged'")
dbus.connect_signal("ru.gentoo.kbdd", function(...)
    local data = { ... }
    local layout = data[2]
    kbdwidget:set_text(lts[layout])
end)

-- }}}

awful.util.spawn_with_shell("killall kbdd; kbdd")
