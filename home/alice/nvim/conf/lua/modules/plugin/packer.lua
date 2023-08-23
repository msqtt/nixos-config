-- packer install, use lazy.nvim for managing plugins. 
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  print("not found lazy.nvim start to install.")
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- install other plugins which come from lua/plugins.
local fp = require("utils").fp
local opts = require("modules.plugin.packer_opt")

local plugin_fnames = require("plugins")
local plugins = fp.map(plugin_fnames, function(e) return require("plugins."..e) end)

 require("lazy").setup(plugins, opts)
