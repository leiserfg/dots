local gears = require("gears")
-- local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme = {}

local main_color = "#afcfee"
theme.dir = os.getenv("HOME") .. "/.config/awesome/themes/steamburn"
theme.wallpaper = os.getenv("HOME") .. "/wall.png"
theme.font = "Lato"
theme.fg_normal = "#e2ccb0"
theme.fg_focus = main_color --
theme.fg_urgent = "#CC9393"
theme.bg_normal = "#140c0b"
theme.bg_focus = "#140c0b"
theme.bg_urgent = "#2a1f1e"
theme.border_width = dpi(1)
theme.border_normal = "#302627"
theme.border_focus = main_color
theme.border_marked = "#CC9393"
theme.taglist_fg_focus = main_color --"#d88166"
theme.tasklist_bg_focus = "#140c0b"
theme.tasklist_fg_focus = main_color
theme.taglist_squares_sel = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel = theme.dir .. "/icons/square_unsel.png"
theme.menu_height = dpi(16)
theme.menu_width = dpi(140)
theme.awesome_icon = theme.dir .. "/icons/awesome.png"
theme.menu_submenu_icon = theme.dir .. "/icons/submenu.png"
theme.layout_txt_tile = "[t]"
theme.layout_txt_tileleft = "[l]"
theme.layout_txt_tilebottom = "[b]"
theme.layout_txt_tiletop = "[tt]"
theme.layout_txt_fairv = "[fv]"
theme.layout_txt_fairh = "[fh]"
theme.layout_txt_spiral = "[s]" theme.layout_txt_dwindle = "[d]"
theme.layout_txt_max = "[m]"
theme.layout_txt_fullscreen = "[F]"
theme.layout_txt_magnifier = "[M]"
theme.layout_txt_floating = "[|]"
theme.tasklist_plain_task_name = true
theme.tasklist_disable_icon = true
theme.useless_gap = dpi(2)

theme.notification_icon_size = dpi(96)

theme.layout_txt_termfair = "[termfair]"
theme.layout_txt_centerfair = "[centerfair]"
theme.gap_single_client = false



-- Textclock
local mytextclock = wibox.widget.textclock(" %H:%M ")
mytextclock.font = theme.font

local spr = wibox.widget.textbox(" ")

local function update_txt_layoutbox(s)
    -- Writes a string representation of the current layout in a textbox widget
    local txt_l = theme["layout_txt_" .. awful.layout.getname(awful.layout.get(s))] or ""
    s.mytxtlayoutbox:set_text(txt_l)
end

function theme.at_screen_connect(s)
    -- Quake application
    -- s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.centered(wallpaper, s)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Textual layoutbox
    s.mytxtlayoutbox = wibox.widget.textbox(theme["layout_txt_" .. awful.layout.getname(awful.layout.get(s))])
    awful.tag.attached_connect_signal(s, "property::selected", function()
        update_txt_layoutbox(s)
    end)
    awful.tag.attached_connect_signal(s, "property::layout", function()
        update_txt_layoutbox(s)
    end)
    s.mytxtlayoutbox:buttons(my_table.join(
        awful.button({}, 1, function()
            awful.layout.inc(1)
        end),
        awful.button({}, 2, function()
            awful.layout.set(awful.layout.layouts[1])
        end),
        awful.button({}, 3, function()
            awful.layout.inc(-1)
        end),
        awful.button({}, 4, function()
            awful.layout.inc(1) end),
        awful.button({}, 5, function()
            awful.layout.inc(-1)
        end)
    ))

    -- Create a taglist widgets
    --
    local function tags_filter(t)
        return t.selected or #t:clients() > 0
    end

    s.mytaglist = awful.widget.taglist(s, tags_filter, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.focused,
        buttons = awful.util.tasklist_buttons,
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(18) })

    -- Add widgets to the wibox
    s.mywibox:setup({
        layout = wibox.layout.align.horizontal,
        expand = "none",
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            spr,
            s.mytaglist,
            spr,
            s.mytxtlayoutbox,
            --spr,
            s.mypromptbox,
            spr,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            mytextclock,
        },
    })
end

return theme
