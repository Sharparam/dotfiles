local hostname = (function()
    local f = io.popen '/bin/hostname'
    local hostname = f:read('*a') or ''
    f:close()
    hostname = hostname:gsub('\n$', '')
    return hostname
end)()

local wezterm = require 'wezterm'

local config = {
    audible_bell = 'Disabled',
    enable_wayland = true,
    hide_tab_bar_if_only_one_tab = true,
    initial_cols = 120,
    initial_rows = 30,
    tab_bar_at_bottom = true,
    term = 'wezterm',
    use_fancy_tab_bar = false,
    use_ime = true
}

local DEFAULT_FONT_SIZE = 12
local font_size = ({})[hostname] or DEFAULT_FONT_SIZE

config.font = wezterm.font 'Cascadia Code PL'
config.font_size = font_size

if hostname == 'melina' then
    config.window_background_opacity = 0.95
end

return config
