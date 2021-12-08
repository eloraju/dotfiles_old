from libqtile.lazy import lazy

browser = "brave"
gui_editor = "intellij-idea-ultimate-edition"

programs = {
        "F1":lazy.spawn(browser),
        "F2":lazy.spawn(gui_editor),
        "F3":lazy.spawn("timer-for-harvest"),
        }
