## Bar config here to make it a bit more understandable

from libqtile import widget, bar
from libqtile.config import Screen
from libqtile.widget import net
from shared import monitorCount, FONT, colors, bar_theme
import socket

####################
####    BARS    ####
####################
hostname = socket.gethostname()
pipeSpacer = widget.TextBox(
        **bar_theme,
        text = "|",
        )

left = [
        widget.GroupBox(
            **bar_theme,
            active = colors["light_gray"],
            inactive = colors["gray"],
            highlight_method = "block",
            highlight_color = colors["green"],
            other_current_screen_border = colors["med_green"],
            other_screen_border = colors["med_gray"],
            this_current_screen_border = colors["med_green"],
            this_screen_border = colors["med_gray"],

            rounded = False,
            use_mouse_wheel = False,
            margin = 2,
            borderwidth = 1,
            ),
        pipeSpacer,
        widget.CurrentLayout(
            **bar_theme,
            #scale = 0.6
            ),
        ]

middle = [
        widget.Clock(
            **bar_theme,
            format="%a %d.%m. %H:%M",
            ),
        ]

right = [
        pipeSpacer,
        widget.CPU(
            **bar_theme,
            color_low=colors["med_green"],
            color_medium=colors["yellow"],
            color_high=colors["red"],
            threshold_medium = 50,
            threshold_high = 75,
            format="cpu {load_bar} {load_percent}%"
            ),
        pipeSpacer,
        widget.Memory(
            **bar_theme,
            color_low=colors["med_green"],
            format="mem {MemBar} {MemPercent}%"
            )
        ]

mainWidgets = [
        *left,
        widget.Spacer(**bar_theme),
        * middle,
        widget.Spacer(**bar_theme),
        *right
    ]

secondaryWidgets = [
        widget.AGroupBox(
            **bar_theme,
            #active = colors["light_gray"],
            #inactive = colors["gray"],
            #highlight_method = "line",
            #hide_unused = True,
            #rounded = False,
            #use_mouse_wheel = False
            ),
        widget.Spacer(**bar_theme),
        widget.Clock(
            **bar_theme,
            format="%a %d.%m. %H:%M",
            ),
        widget.Spacer(**bar_theme),
        ]

#if hostname == "carbon":
#    mainWidgets.append([
#        widget.Wlan(
#            **bar_theme,
#            disconnected_message = "No connection",
#            )
#        ])
#elif hostname == "asgard":
#    mainWidgets.append([
#            widget.Net(interface="enp7s0")
#        ])

primaryBar = bar.Bar(mainWidgets, 23)
secondaryBar = bar.Bar(secondaryWidgets, 23)

#######################
####    SCREENS    ####
#######################
screens = [Screen(top=primaryBar)]
mons = monitorCount()
if mons > 1:
    for mon in range(mons - 1):
        screens.append(Screen(top=secondaryBar))


