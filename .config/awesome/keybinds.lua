local awful = require("awful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")
local util = require("utils")

---------------------------------
----    DEFINING VARIABLES   ----
---------------------------------
ALT = "Mod1"
CONTROL = "Control"
RETURN = "Return"
SHIFT = "Shift"
SPACE = "Space"
TAB = "Tab"
WIN = "Mod4"
HYPER = { WIN, ALT, SHIFT, CONTROL }

MEDIA_KEYS = {
  play = "XF86AudioPlay",
  pause = "XF86AudioStop",
  prev = "XF86AudioPrev",
  next = "XF86AudioNext",
  vol_up = "XF86AudioRaiseVolume",
  vol_down = "XF86AudioLowerVolume",
  mute = "XF86AudioMute",
  mic_mute = "XF86AudioMicMute",
  bright_down = "XF86MonBrightnessDown",
  bright_up = "XF86MonBrightnessUp",
}

-- Testing with xephyr
if os.getenv("WM_TESTING") == nil or os.getenv("WM_TESTING") == "" then
  MOD = WIN
else
  MOD = ALT
  ALT = WIN
  HYPER = { MOD, SHIFT, CONTROL }
end

M = { MOD }
M_Ctl_Sft = { MOD, CONTROL, SHIFT }
M_Sft = { MOD, SHIFT }
M_Ctl = { MOD, CONTROL }
------------------------------
----    END VARIABLES     ----
------------------------------

local globalkeys = {
  -- Basic controls
  awful.key(HYPER, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
  awful.key(HYPER, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),
  awful.key(HYPER, "s", util.suspend, { description = "suspend system", group = "awesome" }),
  awful.key(HYPER, "l", util.lock, { description = "lock screen", group = "awesome" }),
  awful.key(M, "Return", util.spawnTerm, { description = "open a terminal", group = "launcher" }),
  awful.key(M, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
  awful.key(M, "Escape", awful.tag.history.restore, { description = "return to previously selected", group = "tag" }),

  -- Client calls
  awful.key(M, "j", util.focusNext, { description = "focus next by index", group = "client" }),
  awful.key(M, "k", util.focusPrevious, { description = "focus previous by index", group = "client" }),
  awful.key(M_Sft, "j", util.moveClientUp, { description = "swap with next client by index", group = "client" }),
  awful.key(M_Sft, "k", util.moveClientDown, { description = "swap with previous client by index", group = "client" }),
  awful.key(M, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),

  -- Screen manipulation
  awful.key(M, "Tab", util.nextScreen, { description = "focus the next screen", group = "screen" }),
  awful.key(M_Sft, "Tab", util.prevScreen, { description = "focus the previous screen", group = "screen" }),

  -- Layout manipulation
  awful.key(M, "l", util.increaseMasterFactor, { description = "increase master width factor", group = "layout" }),
  awful.key(M, "h", util.decreaseMasterFactor, { description = "decrease master width factor", group = "layout" }),
  awful.key(M_Sft, "h", util.increaseMasterCount, { description = "increase the number of master clients", group = "layout" }),
  awful.key(M_Sft, "l", util.decreaseMasterCount, { description = "decrease the number of master clients", group = "layout" }),
  awful.key(M_Ctl, "h", util.increaseColCount, { description = "increase the number of columns", group = "layout" }),
  awful.key(M_Ctl, "l", util.decreaseColCount, { description = "decrease the number of columns", group = "layout" }),
  awful.key(M, "space", util.nextLayout, { description = "select next", group = "layout" }),
  awful.key(M_Sft, "space", util.prevLayout, { description = "select previous", group = "layout" }),

  -- Why is this here?
  awful.key(M_Ctl, "n", util.restoreMinimized, { description = "restore minimized", group = "client" }),

  -- Launcher and apps
  awful.key(M_Sft, "Return", util.spawnRofi, { description = "run rofi", group = "launcher" }),
  awful.key(M_Sft, "p", util.screenshot, { description = "run flameshot", group = "launcher" }),
  awful.key(M, "p", util.screenshotQuick, { description = "run flameshot", group = "launcher" }),

  awful.key(M, "F1", util.openBrowser, { description = "open browser", group = "launcher" }),
  awful.key(M_Sft, "F1", util.openBrowserIncog, { description = "open browser in incognito", group = "launcher" }),
  awful.key(M, "F2", util.openIde, { description = "open ide", group = "launcher" }),
  awful.key(M, "F12", util.setWallpaper, { description = "open ide", group = "launcher" }),

  -- Tag keys
  awful.key {
    modifiers   = M,
    keygroup    = "numrow",
    description = "only view tag",
    group       = "tag",
    on_press    = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        tag:view_only()
      end
    end,
  },
  awful.key {
    modifiers   = M_Ctl,
    keygroup    = "numrow",
    description = "toggle tag",
    group       = "tag",
    on_press    = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end,
  },
  awful.key {
    modifiers   = M_Sft,
    keygroup    = "numrow",
    description = "move focused client to tag",
    group       = "tag",
    on_press    = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end,
  },
  awful.key {
    modifiers   = M_Ctl_Sft,
    keygroup    = "numrow",
    description = "toggle focused client on tag",
    group       = "tag",
    on_press    = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end,
  },
}

local clientkeys = {
  awful.key(M_Ctl, "Return", util.moveToMaster, { description = "duplicate current terminal", group = "launcher" }),
  awful.key(M, "f", util.toggleFullscreen, { description = "toggle fullscreen", group = "client" }),
  awful.key(M_Sft, "q", util.killClient, { description = "close", group = "client" }),
  awful.key(M, "o", util.moveToScreen, { description = "move to screen", group = "client" }),
  awful.key(M, "t", util.toggleKeepOnTop, { description = "toggle keep on top", group = "client" }),
  awful.key(M, "n", util.minimizeClient, { description = "minimize", group = "client" }),
}

local clientbuttons = {
  awful.button({}, 1, util.activateClient),
  awful.button(M, 1, util.dragClient),
  awful.button(M, 2, util.toggleFloating),
  awful.button(M, 3, util.resizeClient)
}

return { globalkeys = globalkeys, clientkeys = clientkeys, clientbuttons = clientbuttons }

