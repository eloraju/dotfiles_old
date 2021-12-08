from libqtile.lazy import lazy

################################
####    COLORS AND FONTS    ####
################################
FONT = "JetBrainsMono Nerd Font Mono"


colors = {
        "light_gray": "CECECE",
        "med_gray": "868686",
        "gray": "3D3D3D",
        "green": "82DF53",
        "med_green": "218230",
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
        "border_width": 2,
        "border_focus": colors["med_green"],
        "border_normal": colors["gray"],
        }

def run_child_process(script):
    return None

def run_script(script):
    return lazy.spawn(["sh", "-c", script])
