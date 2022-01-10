# Bar config here to make it a bit more understandable

from libqtile import widget, bar
from libqtile.config import Screen
from libqtile.widget import net
from helpers import monitorCount
from shared import FONT, colors, bar_theme
from socket import gethostname

screens = []
mons = monitorCount()
for mon in range(mons):

    ####################
    ####    BARS    ####
    ####################
    pipeSpacer = widget.TextBox(
        **bar_theme,
        text="|",
    )

    left = [
        widget.GroupBox(
            **bar_theme,
            active=colors["light_gray"],
            inactive=colors["gray"],
            highlight_method="block",
            highlight_color=colors["green"],
            other_current_screen_border=colors["black"],
            other_screen_border=colors["black"],
            this_current_screen_border=colors["med_green"],
            this_screen_border=colors["med_gray"],

            rounded=False,
            use_mouse_wheel=False,
            margin=2,
            borderwidth=1,
        ),
        pipeSpacer,
        widget.CurrentLayout(
            **bar_theme,
            # scale = 0.6
        ),
    ]

    middle = [
        widget.Clock(
            **bar_theme,
            format="%a %d.%m. %H:%M",
        ),
    ]

    right = [
        widget.CPU(
            **bar_theme,
            format="cpu {load_percent}%"
        ),
        pipeSpacer,
        widget.Memory(
            **bar_theme,
            format="mem {MemPercent}%"
        ),
        pipeSpacer,
        widget.Systray(**bar_theme)
    ]

    if gethostname() == "carbon":
        right.insert(0, widget.Wlan(
            **bar_theme,
            disconnected_message="No connection",
            format="{essid}",
            interface="wlp0s20f3"
            ))
        right.insert(1, pipeSpacer)
        right.extend([
            pipeSpacer,
            widget.Battery(
            **bar_theme,
            format="{char}{percent:2.0%} ({hour:d}:{min:02d})",
            update_interval=60,
            charge_char="+",
            discharge_char="-",
            notify_below=0.11
            )])


    widgets=[
        *left,
        widget.Spacer(**bar_theme),
        * middle,
        widget.Spacer(**bar_theme),
        *right
    ]

    screens.append(Screen(top=bar.Bar(widgets, 23)))
