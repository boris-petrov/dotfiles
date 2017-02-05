local awful   = require("awful")
local os      = require("os")
local math    = require("math")
local string  = require("string")
local naughty = require("naughty")

module("calendar2")

local calendar = nil
local offset = 0

function remove_calendar()
    if calendar ~= nil then
        naughty.destroy(calendar)
        calendar = nil
        offset = 0
    end
end

function add_calendar(inc_offset)
    local save_offset = offset
    remove_calendar()
    offset = save_offset + inc_offset
    local datespec = os.date("*t")
    datespec = datespec.year * 12 + datespec.month - 1 + offset
    datespec = (datespec % 12 + 1) .. " " .. math.floor(datespec / 12)
    awful.spawn.easy_async("cal -m " .. datespec, function (stdout)
        local cal = string.gsub(stdout, "^%s*(.-)%s*$", "%1")
        calendar = naughty.notify({
            text = string.format('<span font_desc="%s">%s</span>', "monospace", os.date("%a, %d %B %Y") .. "\n\n" .. cal),
            timeout = 0, hover_timeout = 0.5,
            width = 160, height = 130,
        })
    end)
end

function addCalendarToWidget(widget)
    widget:connect_signal("mouse::enter", function()
        add_calendar(0)
    end)
    widget:connect_signal("mouse::leave", remove_calendar)

    widget:buttons(awful.util.table.join(
        awful.button({ }, 1, function()
            add_calendar(1)
        end),
        awful.button({ }, 3, function()
            add_calendar(-1)
        end)
    ))
end
