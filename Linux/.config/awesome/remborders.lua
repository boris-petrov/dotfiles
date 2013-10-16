local awful     = require("awful")
local beautiful = require("beautiful")

for s = 1, screen.count() do
    screen[s]:connect_signal("arrange", function()
        local clients = awful.client.visible(s)
        local layout  = awful.layout.getname(awful.layout.get(s))

        for _, c in ipairs(clients) do
            -- No borders with only one visible client
            if #clients == 1 or layout == "max" then
                c.border_width = 0
            else
                c.border_width = beautiful.border_width
            end
        end
    end)
end
