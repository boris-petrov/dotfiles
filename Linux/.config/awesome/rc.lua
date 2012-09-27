-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- load the 'run or raise' function
require("aweror")
-- remove borders when only a single window is visible
require("remborders")

require("obvious.battery")

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
    awesome.add_signal("debug::error", function (err)
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

modkey = "Mod1"

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

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {
    layouts = { layouts[4], layouts[4], layouts[4], layouts[3], layouts[4],
                layouts[4], layouts[4], layouts[4], layouts[4] }
}

for s = 1, screen.count() do
    tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, tags.layouts)
end
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })

-- Create a systray
mysystray = widget({ type = "systray" })

-- Keyboard layout widget
kbdwidget = widget({type = "textbox", name = "kbdwidget"})
kbdwidget.border_width = 1
kbdwidget.border_color = beautiful.fg_normal
kbdwidget.text = " En "

-- Create a wibox for each screen and add it
mywibox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                        awful.button({ }, 1, awful.tag.viewonly)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              -- This will also un-minimize
                                              -- the client, if needed
                                              client.focus = c
                                              c:raise()
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts,  1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mytaglist[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        mytextclock,
        kbdwidget,
        obvious.battery(),
        s == 1 and mysystray or nil,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey            }, "l", function () awful.util.spawn("xlock -mode blank") end),

    awful.key({ modkey,           }, "`", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),

    -- Standard program
    awful.key({ modkey, "Shift" }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Shift" }, "r",      awesome.restart),
    awful.key({ modkey, "Shift" }, "q",      awesome.quit),
    awful.key({ modkey          }, "h",      function () awful.util.spawn(hostile_takeover) end),

    -- awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    -- awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey, "Control" }, "space", function () awful.layout.inc(layouts,  1) end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,            "Shift" }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey,                    }, "q",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control", "Shift" }, "f",      awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control", "Shift" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,                    }, "o",      awful.client.movetoscreen                        ),
    -- awful.key({ modkey, "Shift"            }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,                    }, "a",      function (c) c.minimized = true               end),
    awful.key({ modkey,                    }, "s",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          tag = tags[client.focus.screen][i]
                          awful.client.movetotag(tag)
                          awful.tag.viewonly(tag)
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ },        1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize)
)

-- generate and add the 'run or raise' key bindings to the globalkeys table
globalkeys = awful.util.table.join(globalkeys, aweror.genkeys(modkey))

-- Set keys
root.keys(globalkeys)
-- }}}

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
    { rule = { class = "Skype", name = "File Transfers" },
      properties = { tag = tags[1][4], focus = false } },
    { rule = { class = "Pidgin" },
      properties = { tag = tags[1][4], focus = false } },
    { rule = { class = "Deadbeef" },
      properties = { tag = tags[1][7] } },
    { rule = { class = "Thunderbird" },
      properties = { tag = tags[screen.count()][8] } },
    { rule = { class = "Deluge" },
      properties = { tag = tags[1][9] } },
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
client.add_signal("manage", function (c, startup)
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
client.add_signal("manage", function (c, startup)
    if c.class == "Pidgin" and c.name and c.name:match("#airian") then
        c:add_signal("property::urgent", function (cl)
            cl.urgent = false
        end)
    end
end)

client.add_signal("focus",   function(c) c.border_color = beautiful.border_focus  end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

dbus.request_name("session", "ru.gentoo.kbdd")
dbus.add_match("session", "interface='ru.gentoo.kbdd',member='layoutChanged'")
dbus.add_signal("ru.gentoo.kbdd", function(...)
    local data = { ... }
    local layout = data[2]
    lts = { [0] = " En ", [1] = " Bg " }
    kbdwidget.text = lts[layout]
end)

-- }}}

awful.util.spawn_with_shell("killall kbdd; kbdd")
awful.util.spawn_with_shell("awsetbg -c ~/.config/awesome/themes/wallpaper.jpg")
