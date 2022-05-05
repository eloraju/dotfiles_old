local leader = require("awesome-leader")
local util = require("utils")

local chords = {}
local wallpaperKeys = leader.bind_actions({
  {
    "e",
    util.nextWP,
    "next wallpaper"
  },
  {
    "w",
    util.favWP,
    "favourite wallpaper"
  },
  {
    "q",
    util.prevWP,
    "previous wallpaper"
  }
})

chords.wallpaperKeys = leader.leader(wallpaperKeys, "Chords");
leader.set_timeout(10)

return chords
