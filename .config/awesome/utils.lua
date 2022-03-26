local awful = require("awful")
local shared = require("shared")
local conf = shared.conf
local scripts = shared.scripts

local utils = {}

function runScript(script)
  print("Trying to execute "..script)
  awful.spawn.with_shell(script)
end

utils.spawnTerm = function ()
  awful.spawn(conf.terminal)
end

utils.suspend = function()
  awful.spawn.with_shell(scripts.suspend)
end

utils.focusNext = function()
  awful.client.focus.byidx(1)
end

utils.focusPrevious = function()
  awful.client.focus.byidx(-1)
end

utils.moveClientUp = function ()
  awful.client.swap.byidx(1)
end

utils.moveClientDown = function()
  awful.client.swap.byidx(-1)
end

utils.nextScreen = function()
  awful.screen.focus_relative(1)
end

utils.prevScreen = function()
  awful.screen.focus_relative(-1)
end

utils.increaseMasterFactor = function ()
  awful.tag.incmwfact(0.05)
end

utils.decreaseMasterFactor = function ()
  awful.tag.incmwfact(-0.05)
end

utils.increaseMasterCount = function()
  awful.tag.incnmaster(1, nil, true)
end

utils.decreaseMasterCount = function()
  awful.tag.incnmaster(-1, nil, true)
end

utils.increaseColCount = function ()
  awful.tag.incncol(1, nil, true)
end

utils.decreaseColCount = function ()
  awful.tag.incncol(-1, nil, true)
end

utils.nextLayout = function()
  awful.layout.inc(1)
end

utils.prevLayout = function()
  awful.layout.inc(-1)
end

-- Client helpers

utils.toggleFullscreen = function (client)
  client.fullscreen = not client.fullscreen
  client:raise()
end

utils.minimizeClient = function(client)
  client.minimized = true
end

utils.restoreMinimized = function()
  local c = awful.client.restore()
  -- Focus restored client
  if c then
    c:emit_signal(
        "request::activate", "key.unminimize", {raise = true}
    )
  end
end

utils.killClient = function(client)
  client:kill()
end

utils.moveToMaster = function(client)
  client:swap(awful.client.getmaster())
end

utils.moveToScreen = function(client)
  client:move_to_screen()
end

utils.toggleKeepOnTop = function(client)
  client.ontop = not client.ontop
end

-- Run helpers

utils.spawnRofi = function()
  awful.spawn(scripts.run_rofi)
end

utils.screenshotQuick = function()
  awful.spawn("flameshot gui")
end

utils.screenshot = function()
  awful.spawn("flameshot launcher")
end

utils.openBrowser = function()
  awful.spawn(conf.browser)
end

utils.openBrowserIncog = function()
  awful.spawn(conf.browser_incognito)
end

utils.openIde = function()
  awful.spawn(conf.ide)
end

-- Mouse button helpers

utils.activateClient = function(client)
  client:emit_signal("request::activate", "mouse_click", {raise=true})
end

utils.dragClient = function(client)
  utils.activateClient(client)
  awful.mouse.client.move(client)
end

utils.resizeClient = function(client)
  utils.activateClient(client)
  awful.mouse.client.resize(client)
end

utils.toggleFloating = function(client)
  utils.activateClient(client)
  client.floating = not client.floating
  awful.mouse.client.move(client)
end

-- Other helper functions

utils.setWallpaper = function(screen)
  awful.spawn.with_shell(shared.scripts.randomWP)
end

-- Bar mous bindings

utils.taskListToggleMinimized = function (client)
  if client == client.focus then
      client.minimized = true
  else
      client:emit_signal(
          "request::activate",
          "tasklist",
          {raise = true}
      )
  end
end

utils.showTasklist = function()
  awful.menu.client_list({ theme = { width = 250 } })
end

return utils