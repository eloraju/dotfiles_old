from libqtile import layout, hook, bar
from libqtile.config import Key, Group, Drag, Click, Screen
from libqtile.lazy import lazy
from libqtile import widget

from os import environ
from os import path, environ

from typing import List
from screenHelper import monitorCount

import socket
import subprocess
import sys

#################################
####    DEFINING VARIABLES   ####
#################################
ALT = 'mod1'
CONTROL = 'control'
RETURN = 'Return'
SHIFT = 'shift'
SPACE = 'space'
TAB = 'Tab'
WIN = 'mod4'
HYPER = [WIN, ALT, SHIFT, CONTROL]

# Switch the mods around if we're testing
if environ.get('QTILE_XEPHYR'):
    MOD = ALT
    ALT = WIN
else:
    MOD = WIN


terminal = "alacritty"
browser = "brave"

#######################
####    SCRIPTS    ####
#######################

screenshot = ""

################################
####    COLORS AND FONTS    ####
################################
FONT = "JetBrainsMono Nerd Font Mono"

colors = {
        "normal": "#cecece",
        "green": "82DF53",
        "inactive": "3d3d3d",
        "red": "D00000",
        "yellow": "FFBA08", 
        "background": "141214"
        }

shared_bar_confs = {
        "background": colors["background"],
        "font": FONT,
        "foreground": colors["normal"],
        }

############################
####    KEY BINDINGS    ####
############################
keys = [
        # WM control
        Key(HYPER, "r", lazy.restart()),
        Key(HYPER, "q", lazy.shutdown()),

        # Window controls
        Key([MOD], "j", lazy.layout.down()),
        Key([MOD], "k", lazy.layout.up()),
        Key([MOD, SHIFT], "j", lazy.layout.shuffle_down()),
        Key([MOD, SHIFT], "k", lazy.layout.shuffle_up()),

        Key([MOD], "Return", lazy.spawn(terminal)),
        Key([MOD], "Tab", lazy.next_layout()),
        Key([MOD, SHIFT], "q", lazy.window.kill()),

        Key([MOD, SHIFT],'b', lazy.hide_show_bar("bottom"))
        ]

############################
####    MOUSE BINDINGS  ####
############################
mouse = [
        Drag([MOD], "Button1", lazy.window.set_position_floating(),
            start=lazy.window.get_position()),
        Drag([MOD], "Button3", lazy.window.set_size_floating(),
            start=lazy.window.get_size()),
        Click([MOD], "Button2", lazy.window.bring_to_front())
        ]

####################
####    GROUPS  ####
####################
groupNames = ['I','II','III','IV','V','VI','VII','VIII','IX','X']
groups = [Group(i) for i in groupNames]

for i in groups:
    numKey = groups.index(i)+1;
    if numKey == 10:
        numKey = 0
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([MOD], str(numKey), lazy.group[i.name].toscreen()),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([MOD, "shift"], str(numKey), lazy.window.togroup(i.name, switch_group=True))
        ])

    ########################
####    LAYOUTS     ####
########################
layouts = [
        layout.MonadTall(),
        layout.Bsp(),
        layout.Columns(),
        layout.Matrix(),
        layout.MonadWide(),
        layout.RatioTile(),
        layout.Tile(),
        layout.TreeTab(),
        layout.VerticalTile(),
        layout.Zoomy(),
        ]

####################
####    BARS    ####
####################
hostname = socket.gethostname()
pipeSpacer = widget.TextBox(
        **shared_bar_confs,
        text = "|",
        )

left = [
        widget.CurrentScreen(
            **shared_bar_confs,
            active_color = colors["green"],
            active_text = "1",
            inactive_text = "0",
            inactive_color = colors["red"],
            ),
        widget.GroupBox(
            **shared_bar_confs,
            active = colors["normal"],
            inactive = colors["inactive"],
            highlight_method = "text",
            hide_unused = True,
            rounded = False,
            use_mouse_wheel = False
            ),
        widget.CurrentLayoutIcon(
            **shared_bar_confs,
            scale = 0.6
            ),
        ]

middle = [
        widget.Clock(
            **shared_bar_confs,
            format="%a %d.%m. %H:%M",
            ),
        ]

right = [
        widget.CPU(
            **shared_bar_confs,
            color_low=colors["green"],
            color_medium=colors["yellow"],
            color_high=colors["red"],
            threshold_medium = 10,
            threshold_high = 25,
            format="cpu {load_bar} {load_percent}%"
            ),
        pipeSpacer,
        widget.Memory(
            **shared_bar_confs,
            color_low=colors["green"],
            format="mem {MemBar} {MemPercent}%"
            )
        ]

mainWidgets = [
        *left,
        widget.Spacer(**shared_bar_confs),
        * middle,
        widget.Spacer(**shared_bar_confs),
        *right
    ]

if hostname == "carbon":
    mainWidgets.append([
        widget.Wlan(
            **shared_bar_confs,
            disconnected_message = "No connection",
            font = FONT,
            )
        ])
#elif hostname == "asgard":
#    mainWidgets.append([
#            widget.Net(interface="enp7s0")
#        ])

primaryBar = bar.Bar(mainWidgets, 20)
secondaryBar = bar.Bar([], 20)

#######################
####    SCREENS    ####
#######################
screens = [Screen(top=primaryBar)]
mons = monitorCount()
if mons > 1:
    for mon in range(mons - 1):
        screens.append(Screen(top=secondaryBar))



dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
