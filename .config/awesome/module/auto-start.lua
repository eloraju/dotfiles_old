-- Autostart from https://github.com/doronbehar/awesome-autostart
local Autostart = require('autostart')

local autostart_conf = {
  programs = {
    { bin = 'picom' },
    { bin = 'nm-applet' },
    { bin = 'xbanish' },
    { bin = 'blueman-applet' },
    { bin = '1password', '--silent' },
    { bin = 'variety' },
  }
}

Autostart(autostart_conf):run_all()
