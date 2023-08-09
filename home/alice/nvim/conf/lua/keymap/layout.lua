local u = require("keymap.utils")
local mod, map, opt = u.mod, u.map, u.opt

local function mapLayout(mode, pre, now)
	local ot = opt():Nore()
	map(mode, pre, now, ot)
	map(mode, now, pre, ot)
	pre = string.upper(pre)
	now = string.upper(now)
	map(mode, pre, now, ot)
	map(mode, now, pre, ot)
end

local modnx = mod():n():x()
local modnxo = mod():n():x():o()

mapLayout(modnx, "n", "j")
mapLayout(modnx, "e", "k")
mapLayout(modnxo, "y", "h")
-- cause a bug
mapLayout(modnx, "o", "l")
