from Xlib import display as xdisplay
from libqtile.lazy import lazy

################################
####    COLORS AND FONTS    ####
################################
FONT = "JetBrainsMono Nerd Font Mono"

colors = {
        "light_gray": "CECECE",
        "gray": "3D3D3D",
        "green": "82DF53",
        "dark_green": "144D1D",
        "dark_red": "7A0000",
        "red": "D00000",
        "dark_yellow": "C59100", 
        "yellow": "FFBA08", 
        "black": "141214"
        }

bar_theme = {
        "background": colors["black"],
        "font": FONT,
        "foreground": colors["light_gray"],
        }

layout_theme = {
        "border_width": 1,
        "border_focus": colors["green"],
        "border_normal": colors["gray"],
        }

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

def run_child_process(script):
    return None

def run_script(script):
    return lazy.spawn(["sh", "-c", script])
