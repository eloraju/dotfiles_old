from libqtile import hook
from shared import run_child_process, run_script
from subprocess import Popen


@hook.subscribe.client_new
def floating_dialogs(window):
    dialog = window.window.get_wm_type() == 'dialog'
    transient = window.window.get_wm_transient_for()
    if dialog or transient:
        window.floating = True


@hook.subscribe.startup
def startup():
    calls = [
            ['/home/juuso/.local/user/scripts/setwp', '-r'],
            ['picom', '-b'],
    ]

    for call in calls:
        Popen(call)

