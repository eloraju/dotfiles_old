from libqtile import hook
from shared import run_child_process, run_script
from subprocess import Popen


@hook.subscribe.client_new
def floating_dialogs(window):
    dialog = window.window.get_wm_type() == 'dialog'
    transient = window.window.get_wm_transient_for()
    if dialog or transient:
        window.floating = True

#@hook.subscribe.client_managed
#def handle(window):
#    if "Minecraft" in window.name:
#        window.enable_fullscreen();

@hook.subscribe.startup
def startup():
    calls = [
            ['/home/juuso/.local/user/scripts/setwp', '-r'],
            ['picom', '-b'],
    ]

    for call in calls:
        Popen(call)


# Steam...
@hook.subscribe.client_new
def float_steam(window):
    wm_class = window.window.get_wm_class()
    w_name = window.window.get_name()
    if (
        wm_class == ("Steam", "Steam")
        and (
            w_name != "Steam"
            # w_name == "Friends List"
            # or w_name == "Screenshot Uploader"
            # or w_name.startswith("Steam - News")
            or "PMaxSize" in window.window.get_wm_normal_hints().get("flags", ())
        )
    ):
        window.floating = True
