from libqtile.lazy import lazy
from Xlib import display as xdisplay

def monitorCount():
    num_monitors = 0
    try:
        display = xdisplay.Display()
        screen = display.screen()
        resources = screen.root.xrandr_get_screen_resources()

        for output in resources.outputs:
            monitor = display.xrandr_get_output_info(output, resources.config_timestamp)
            preferred = False
            if hasattr(monitor, "preferred"):
                preferred = monitor.preferred
            elif hasattr(monitor, "num_preferred"):
                preferred = monitor.num_preferred
            if preferred:
                num_monitors += 1
    except Exception:
        # always setup at least one monitor
        return 1
    else:
        return num_monitors

def window_to_next_screen(qtile):
    next_screen = (qtile.screens.index(qtile.currentScreen) + 1) % len(qtile.screens)
    othergroup = None

    for group in qtile.cmd_groups().values():
        if group['screen'] == next_screen:
            othergroup = group['name']
            break

    if othergroup:
        qtile.moveToGroup(othergroup)

# function that generates groups per screen


# function that moves windows within the screen groups
#   - check current screen
#   - prepend the screen id/index to the group name
#   - ==> M_Sft+1 => only moves within screen


# function that moves windows from one screen to the other
#   - check next screen
#   - prepend the screen id/index to the group name
#   - ==> M_Sft+Tab => moves active window to active group on next screen
