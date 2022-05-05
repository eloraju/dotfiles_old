local leader = require("awesome-leader")
local util = require("utils")


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

leader.set_timeout(10)
local chords = leader.leader(wallpaperKeys, "Chords");

return chords
