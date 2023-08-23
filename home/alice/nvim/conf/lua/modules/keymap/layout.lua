local fp = require("utils").fp
local km = require("modules.keymap.utils")
local n, o, x = km.new_mode("n"), km.new_mode("o"), km.new_mode("x")
local nore = km.new_opt("noremap", true)

-- just workman layout movement keys.
local layout = {
  {n+x, "n", "j", nore},
  {n+x, "e", "k", nore},
  {n+x+o, "y", "h", nore},
  {n+x, "o", "l", nore},
}

fp.map(km.reverse_upper_keys(layout), km.uwrap_set)
