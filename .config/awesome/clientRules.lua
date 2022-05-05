local ruled = require("ruled")
local awful = require("awful")

local clienRules = function()
  -- All clients will match this rule.
  ruled.client.append_rule {
    id         = "global",
    rule       = {},
    properties = {
      focus     = awful.client.focus.filter,
      raise     = true,
      screen    = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen
    },
    -- this is dceprecated but still working...
    -- :set_secondary_section() is the new way but didn't work
    -- as a drop in replacement
    callback   = awful.client.setslave
  }

  -- Floating clients.
  ruled.client.append_rule {
    id         = "floating",
    rule_any   = {
      instance = { "copyq", "pinentry" },
      class    = {
        "Arandr",
        "Blueman-manager",
        "Gpick",
        "Kruler",
        "Sxiv",
        "Tor Browser",
        "Wpa_gui",
        "veromix",
        "xtightvncviewer",
        "Timer-for-harvest",
        "droidcam",
        "1Password",
        "net.battlescribe.desktop.rostereditor.RosterEditorApplication"
      },
      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name     = {
        "Event Tester", -- xev.
      },
      role     = {
        "AlarmWindow", -- Thunderbird's calendar.
        "ConfigManager", -- Thunderbird's about:config.
        "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
      }
    },
    properties = { floating = true, ontop = true }
  }

  -- Don't add titlebars
  ruled.client.append_rule {
    id         = "titlebars",
    rule_any   = { type = { "normal", "dialog" } },
    properties = { titlebars_enabled = false }
  }

  -- Make steam games fullscreen automatically
  ruled.client.append_rule {
    id = "fullscreen",
    rule_any = {
      class = {
        "steam_app_*"
      }
    },
    properties = { floating = true, fullscreen = true, ontop = true }
  }

  ruled.client.append_rule {
    id = "steam-windows",
    rule = { class = "Steam" },
    except = { name = "Steam" },
    properties = { floating = true, on_top = true }
  }
end

return clienRules
