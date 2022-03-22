local shared = {
  conf = {},
  scripts = {}
}

shared.conf.terminal = "alacritty"
shared.conf.editor = "nvim"
shared.conf.browser = "brave"
shared.conf.browser_incognito = "brave --incognito"
shared.conf.ide = "intellij-idea-ultimate-edition"
shared.conf.wp_dir = "~/pictures/wallpapers"

shared.scripts.screenshot = "~/.local/user/scripts/screenshot"
shared.scripts.fs_screenshot = "~/.local/user/scripts/screenshot -f"
shared.scripts.randomWP = "~/.local/user/scripts/setwp -r"
-- sudo is conffed not to ask password for this command
shared.scripts.inc_backlight = "sudo xbacklight -inc 10"
shared.scripts.dec_backlight = "sudo xbacklight -dec 10"
shared.scripts.run_rofi = "rofi -show run"

return shared