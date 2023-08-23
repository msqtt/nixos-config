-- here are all pluins' config.
-- the table structure: https://github.com/folke/lazy.nvim#-plugin-spec
local fp = require("utils").fp

local current_dir = vim.fn.expand('%:p:h').."/lua/plugins"

local dir = vim.fs.dir(current_dir)
if dir == nil then
  print("plugins: cannot read path!")
  return
end

local files = fp.filter(dir, function(name, type)
    return type == 'file' and name ~= 'init.lua'
end)

return fp.map(files, function(name)
    return string.gsub(name, '.lua', '')
end)
