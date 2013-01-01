local awful     = require("awful")
local beautiful = require("beautiful")

local function client_maximized(c)
    if c.maximized_horizontally and c.maximized_vertically then
        return true
    end

    local s_geom = screen[c.screen].geometry
    local c_geom = c:geometry()

    if (s_geom.x == c_geom.x and s_geom.y == c_geom.y

        and s_geom.width == c_geom.width and s_geom.height == c_geom.height) then

        return true
    else
        return false
    end
end

local function border_width(screen_index, client)
    if awful.client.floating.get(client) then
        if client_maximized(client) then
            return 0
        else
            return beautiful.border_width
        end
    end

    if (#awful.client.tiled(screen_index) == 1 or
        awful.layout.get(screen_index) == awful.layout.suit.max) then
        return 0
    else
        return beautiful.border_width
    end
end

-- remove borders if only one window is visible
for i = 1, screen.count() do
    screen[i]:connect_signal("arrange", function(s)
        for _, c in ipairs(awful.client.visible(i)) do
            c.border_width = border_width(i, c)
        end
    end)
end
