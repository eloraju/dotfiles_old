from libqtile import layout, hook
from libqtile.config import Key, Group, Drag, Click, ScratchPad, DropDown
from libqtile.lazy import lazy

from os import environ
from os import path, environ
from typing import List
from bar import screens
from shared import colors, layout_theme, run_script, run_child_process
from helpers import window_to_next_screen

import subprocess
import sys
import hooks

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

media_keys = {
        "play":"XF86AudioPlay",
        "pause":"XF86AudioStop",
        "prev":"XF86AudioPrev",
        "next":"XF86AudioNext",
        "vol_up":"XF86AudioRaiseVolume",
        "vol_down":"XF86AudioLowerVolume",
        "mute":"XF86AudioMute",
        "mic_mute":"XF86AudioMicMute",
        "bright_down":"XF86MonBrightnessDown",
        "bright_up":"XF86MonBrightnessUp",
        }

# For testing qtile cong with xephyr
if environ.get('QTILE_XEPHYR'):
    MOD = ALT
    ALT = WIN
else:
    MOD = WIN

M = [MOD]
M_Ctl_Sft = [MOD, CONTROL, SHIFT]
M_Sft = [MOD, SHIFT]
M_Ctl = [MOD, CONTROL]

terminal = "alacritty"
browser = "brave"

#######################
####    SCRIPTS    ####
#######################
screenshot = "sleep 0.2;scrot -s ~/pictures/screenshots/$(date +%F_%T).png -e 'xclip -selection clipboard -t image/png < $f'"
suspend = "systemctl suspend"
change_wallpaper = "~/.local/user/scripts/setwp -r"
start_picom = "picom -b"
emojiCmd = "rofimoji -c --skin-tone neutral --max-recent 0"
inc_backlight = "sudo xbacklight -inc 10"
dec_backlight = "sudo xbacklight -dec 10"

############################
####    KEY BINDINGS    ####
############################
keys = [
    # WM control
    Key(HYPER, "r", lazy.restart()),
    Key(HYPER, "q", lazy.shutdown()),
    Key(HYPER, "s", lazy.spawn(suspend)),

    # Core stuff
    Key(M, "Return", lazy.spawn(terminal)),
    Key(M_Ctl, "Return", lazy.spawn("/home/juuso/.local/user/scripts/duplicate-term")),
    Key(M_Sft, "Return", lazy.spawn("rofi -show run -display-run ''")),
    Key(M_Sft, "q", lazy.window.kill()),

    # Window controls
    Key(M, "j", lazy.layout.down()),
    Key(M, "k", lazy.layout.up()),
    Key(M_Sft, "j", lazy.layout.shuffle_down()),
    Key(M_Sft, "k", lazy.layout.shuffle_up()),

    Key(M, "o", lazy.layout.grow_main()),
    Key(M, "u", lazy.layout.shrink_main()),
    Key(M_Sft, "o", lazy.layout.grow()),
    Key(M_Sft, "u", lazy.layout.shrink()),

    Key(M, "Delete", lazy.window.disable_floating()),
    Key(M, "f", lazy.window.toggle_fullscreen()),

    # Workspaces and screens
    Key(M, "h", lazy.screen.prev_group()),
    Key(M, "l", lazy.screen.next_group()),
    Key(M, "Tab", lazy.next_screen()),
    Key(M_Ctl, "Tab", lazy.next_layout()),
    Key(M_Sft, "Tab", lazy.function(window_to_next_screen)),

    # Media key stuff
    
    Key([], media_keys["bright_down"], run_script(dec_backlight)),
    Key([], media_keys["bright_up"], run_script(inc_backlight)),

    # Spawn stuff and execute
    Key(M_Sft, 'b', lazy.hide_show_bar("top")),
    Key(M_Sft, "p", run_script(screenshot)),
    Key(M, "F1", lazy.spawn(browser)),
    Key(M, "F12", run_script(change_wallpaper)),
    Key(M_Sft, "e", run_script(emojiCmd)),
]

############################
####    MOUSE BINDINGS  ####
############################
mouse = [
    Drag(M, "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag(M, "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click(M, "Button2", lazy.window.disable_floating())
]

####################
####    GROUPS  ####
####################
groupNames = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X']
groups = [Group(i) for i in groupNames]

for i in groups:
    numKey = groups.index(i)+1
    if numKey == 10:
        numKey = 0
    keys.extend([
        Key(M, str(numKey), lazy.group[i.name].toscreen()),
        Key(M_Sft, str(numKey), lazy.window.togroup(i.name, switch_group=False)),
        Key(M_Ctl_Sft, str(numKey), lazy.window.togroup(i.name, switch_group=True))
    ])


########################
####    SCARTCH     ####
########################
groups.append(
    ScratchPad("scratch", [
               DropDown('ala', 'alacritty', on_focus_lost_hide=True),
               DropDown('sla', 'chromium --app=https://app.slack.com/client/T02CLPH0M/unreads', on_focus_lost_hide=True)
               ])
)

########################
####    LAYOUTS     ####
########################
layouts = [
    layout.MonadTall(
        **layout_theme,
        name="tall",
    ),
    layout.MonadWide(
        **layout_theme,
        name="wide"
    ),
    layout.Matrix(
        **layout_theme,
    ),
    layout.Max(
        **layout_theme,
    ),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = False
focus_on_window_activation = "smart"
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {'wmclass': 'confirm'},
    {'wmclass': 'Xephyr'},
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
    {'wname': 'Open Files'},  # File opener
    {'wname': 'Open Folder'},  # File opener
    {'wname': 'Save File'},  # File opener
    {'wmclass': 'timer-for-harvest'},  # File opener
    {'wmclass': 'droidcam'},  # File opener
])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
