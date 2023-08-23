--[[
-- km functions are used to map keys.
--]]
local km = {}

local fp = require("utils").fp
local upack = table.unpack or unpack
local upper = string.upper

-- unwrap a table for vim.keymap.set
km.uwrap_set = function (map)
  vim.keymap.set(upack(map))
end

-- insert reverse and upper keymaps to a new table then return it.
-- used to absolutly swap two keys.
km.reverse_upper_keys = function (tb)
  return fp.reduce(tb, function(acc, e)
      table.insert(acc, e)
      table.insert(acc, {e[1], e[3], e[2], e[4]})
      table.insert(acc, {e[1], upper(e[2]), upper(e[3]), e[4]})
      table.insert(acc, {e[1], upper(e[3]), upper(e[2]), e[4]})
      return acc
  end, {})
end

-- modes and options.
km.new_mode = function (m)
  local tb = {}
  table.insert(tb, m)
  setmetatable(tb, {
    __add = function(s, t)
      return fp.reduce(t, function(acc, e)
          table.insert(acc, v)
          return acc
      end, s)
    end
  })
  return tb
end

km.new_opt = function (k, v)
  local tb = {}
  tb[k] = v
  setmetatable(tb, {
    __add = function(s, t)
      for k, v in pairs(t) do s[k] = v end
      return s
    end
  })
  return tb
end

return km
