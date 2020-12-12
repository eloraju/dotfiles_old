from libqtile.lazy import lazy
from shared import monitorCount

def window_to_next_screen(qtile):
    next_screen = (qtile.screens.index(qtile.currentScreen) + 1) % len(qtile.screens)
    othergroup = None

    for group in qtile.cmd_groups().values():
        if group['screen'] == next_screen:
            othergroup = group['name']
            break

    if othergroup:
        qtile.moveToGroup(othergroup)
